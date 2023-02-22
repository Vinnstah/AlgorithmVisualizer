import ComposableArchitecture
import Foundation
import ChartModel

public extension Sorting {
    func reduce(into state: inout State, action: Action) -> Effect<Action> {
        switch action {

        case let .internal(.arraySizeStepperTapped(value)):
            state.array.values = IdentifiedArray(uniqueElements: self.elementGenerator.generateElements(Int(value)))
            return .none
            
        case let .internal(.sortingTimer(time, type)):
            state.timer = time
            state.historicalSortingTimes.addTime(time: state.timer, type: type)
            print(state.historicalSortingTimes)
            return .none
            
        case .internal(.mergeSortTapped):
            
            guard !state.array.isSorted(order: .increasing) else {
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
                                                             )
                                            )
                        )
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
            state.array.values = IdentifiedArray(uniqueElements: self.elementGenerator.generateElements(20))
            return .none
            
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
                            await self.sortingAlgorithms.bubbleSort(array)
                        }
                                                             )
                                            )
                        )
                    },
                        .bubble
                )))
            }
            .animation()
            
        case let .internal(.bubbleSortResult(.success(data))):
            state.array = data
            return .none
            
        case .internal(.bubbleSortResult(.failure(_))):
            print("BUBBLE FAIL")
            return .none
            
        case  .internal(.toggleErrorPopover):
            state.errorPopoverIsShowing.toggle()
            return .none
            
        case .internal(.resetArrayTapped):
            state.array.values = IdentifiedArray(uniqueElements: self.elementGenerator.generateElements(20))
            state.errorPopoverIsShowing = false
            return .none
        }
    }
}
