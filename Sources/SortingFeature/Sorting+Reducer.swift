import ComposableArchitecture
import Foundation
import UnsortedElements

public extension Sorting {
    func reduce(into state: inout State, action: Action) -> Effect<Action> {
        switch action {
        case let .internal(.arraySizeStepperTapped(count)):
            return generate(count: count)
            
        case let .internal(.sortingTimer(time, type)):
            state.timer = time
            state.historicalSortingTimes.addTime(time: state.timer, type: type)
            print(state.historicalSortingTimes)
            return .none
            
        case .internal(.mergeSortTapped):
            
            guard !state.array.isSorted(order: .increasing) else {
                print("GUARD")
                return .run { send in
                    await send(.internal(.toggleErrorPopover))
                }
            }
            
            state.timer = .zero
            return .run { [array = state.array] send in
                await send(.internal(.sortingTimer(
                    await self.clock.measure {
                        await send(.internal(.mergeSortResult(TaskResult {
                            await sortingAlgorithms.mergeSort(array)
                        }
                                                             )))
                    },
                    .merge
                )))
            }
            .animation()
            
        case let .internal(.mergeSortResult(.success(data))):
            state.array = data
            return .none
            
        case .internal(.mergeSortResult(.failure)):
            print("fail")
            return .none
            
        case .internal(.onAppear):
            return generate()
            
        case .internal(.bubbleSortTapped):
            
            guard !state.array.isSorted(order: .increasing) else {
                return .run { send in
                    await send(.internal(.toggleErrorPopover))
                }
            }
            
            state.timer = .zero
            return .run { [array = state.array] send in
                await send(.internal(.sortingTimer(
                    await self.clock.measure {
                        await send(.internal(.bubbleSortResult(TaskResult {
                            await self.sortingAlgorithms.bubbleSortOutput(array)
//                            await self.sortingAlgorithms.bubbleSort(array)
                        }
                                                              )))
                    },
                    .bubble
                )))
            }
            .animation()
            
        case let .internal(.bubbleSortResult(.success(data))):
//            state.array = data
            return .none
            
        case .internal(.bubbleSortResult(.failure(_))):
            print("BUBBLE FAIL")
            return .none
            
        case .internal(.toggleErrorPopover):
            state.errorPopoverIsShowing.toggle()
            return .none
            
        case .internal(.resetArrayTapped):
            
            state.errorPopoverIsShowing = false
            return generate()
            
        case let .internal(.generateElementsResult(.success(elementsToSort))):
            state.array = elementsToSort
            return .none
        case .internal(.generateElementsResult(.failure)):
            fatalError()
            
        case .task:
            return .run { [animationDelay = state.sortingAnimationDelay] send in
                for try await value in await sortingAlgorithms.bubbleSortReceiver() {
                    guard let value else {
                        return
                    }
                    await send(.internal(.bubbleSortValueResponse(value)), animation: .default)
                    try await Task.sleep(for: .milliseconds(animationDelay) )
                }
            }
        case let .internal(.bubbleSortValueResponse(value)):
            state.array.values.swapAt(value[0].initialPostition, value[1].initialPostition)
            return .none
        case let .internal(.animationDelayStepperTapped(value)):
            state.sortingAnimationDelay = value
            return .none
        }
    }
    
    private func generate(count: UInt = State.defaultElementCount) -> Effect<Action> {
        return .run { send in
            await send(.internal(.generateElementsResult(
                TaskResult {
                    await elementGenerator.generate(count)
                }
            )))
        }
    }
}
