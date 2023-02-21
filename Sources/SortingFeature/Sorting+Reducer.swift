import ComposableArchitecture
import Foundation
import ChartModel

public extension Sorting {
    func reduce(into state: inout State, action: Action) -> Effect<Action> {
        switch action {

        case let .internal(.arraySizeStepperTapped(value)):
            state.array.values = IdentifiedArray(uniqueElements: self.elementGenerator.generateElements(Int(value)))
            state.array.sorted = false
            return .none
            
        case let .internal(.sortingTimer(time)):
            state.timer = time
            return .none
            
        case .internal(.mergeSortTapped):
            
            guard !state.array.sorted else {
                return .run { send in
                    await send(.internal(.toggleErrorPopover(
                        .init("The array is already sorted \n Please reset the array"))))
                }
            }
            
            state.timer = .zero
            return .run { [array = state.array] send in
                await send(.internal(.sortingTimer(
                    await self.clock.measure {
                        await send(.internal(.mergeSortResult(TaskResult {
                            await self.sortingAlgorithms.mergeSort(array)
                        }
                                                             )
                                            )
                        )
                    }
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
            
            guard !state.array.sorted else {
                return .run { send in
                    await send(.internal(.toggleErrorPopover(.init("The array is already sorted \n Please reset the array"))))
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
                    }
                )))
            }
            .animation()
            
        case let .internal(.bubbleSortResult(.success(data))):
            state.array = data
            return .none
            
        case .internal(.bubbleSortResult(.failure(_))):
            print("BUBBLE FAIL")
            return .none
            
        case let .internal(.toggleErrorPopover(textState)):
            state.errorPopoverIsShowing.toggle()
            state.popoverTextState = textState
            return .none
            
        case .internal(.resetArrayTapped):
            state.array.values = IdentifiedArray(uniqueElements: self.elementGenerator.generateElements(20))
            state.array.sorted = false
            return .none
        }
    }
}
