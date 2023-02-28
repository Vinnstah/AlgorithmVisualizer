import ComposableArchitecture
import Foundation
import UnsortedElements

public extension Sorting {
    func reduce(into state: inout State, action: Action) -> Effect<Action> {
        
        switch action {
        case let .view(.arraySizeStepperTapped(count)):
            return .merge(
//                .cancel(id: CancellableID.self),
                generate(count: count)
            )
            
        case let .internal(.sortingTimer(time, type)):
            state.timer = time
            state.historicalSortingTimes.addTime(time: state.timer, type: type)
            return .none
            
        case .internal(.mergeSortTapped):
            
            guard !state.arrayToSort.isSorted(order: .increasing) else {
                return .run { send in
                    await send(.internal(.toggleErrorPopover))
                }
            }
            
            state.timer = .zero
            state.sortingInProgress = true
            return .run { [unsortedArray = state.arrayToSort] send in
                await send(.internal(.sortingTimer(
                    await self.clock.measure {
                        await send(.internal(.mergeSortResult(TaskResult {
                            await sortingAlgorithms.mergeSort(unsortedArray)
                        }
                                                             )))
                    },
                    .merge
                )))
            }
            .animation()
            
        case let .internal(.mergeSortResult(.success(result))):
            state.arrayToSort = result
            state.sortingInProgress = false
            return .none
            
        case .internal(.mergeSortResult(.failure)):
            print("fail")
            return .none
            
        case .internal(.onAppear):
            return generate(count: State.defaultElementCount)
            
        case .internal(.bubbleSortTapped):
            
            guard !state.arrayToSort.isSorted(order: .increasing) else {
                return .run { send in
                    await send(.internal(.toggleErrorPopover))
                }
            }
            
            state.sortingInProgress = true
            state.timer = .zero
            return .run { [unsortedArray = state.arrayToSort] send in
                await send(.task)
                await send(.internal(.sortingTimer(
                    await self.clock.measure {
                        await send(.internal(.bubbleSortResult(TaskResult {
                            await self.sortingAlgorithms.bubbleSortOutput(unsortedArray)
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
            state.sortingInProgress = false
            return .none
            
        case .internal(.bubbleSortResult(.failure(_))):
            print("BUBBLE FAIL")
            return .none
            
        case .internal(.toggleErrorPopover):
            state.errorPopoverIsShowing.toggle()
            return .none
            
        case .view(.resetArrayTapped):
            
            state.errorPopoverIsShowing = false
            state.sortingInProgress = false
            return .concatenate(
                .cancel(id: CancellableID.self),
                generate(count: UInt(state.arrayToSort.values.count))
            )
            
        case let .internal(.generateElementsResult(.success(elementsToSort))):
            state.arrayToSort = elementsToSort
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
            .cancellable(id: CancellableID.self, cancelInFlight: true)
            
        case let .internal(.bubbleSortValueResponse(value)):
            state.arrayToSort.values.swapAt(value[0].initialPostition, value[1].initialPostition)
            return .none
            
        case let .view(.animationDelayStepperTapped(value)):
            state.sortingAnimationDelay = value
            return .none
        }
    }
    
    private func generate(count: UInt) -> Effect<Action> {
        return .run { send in
            await send(.internal(.generateElementsResult(
                TaskResult {
                    await elementGenerator.generate(count)
                }
            )))
        }
    }
    
    private func cancelTask() -> Effect<Action> {
        return .cancel(id: CancellableID.self)
    }
}

private enum CancellableID: Hashable {}
