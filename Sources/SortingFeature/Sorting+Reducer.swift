import ComposableArchitecture
import Foundation
import ChartModel

public extension Sorting {
    func reduce(into state: inout State, action: Action) -> Effect<Action> {
        switch action {
            
        case let .internal(.arraySizeStepperTapped(value)):
            state.array.values = self.elementGenerator.generateElements(Int(value))
            return .none
        case let .internal(.sortingTimer(time)):
            state.timer = time
            return .none
            
        case .internal(.mergeSortTapped):
            state.timer = .zero
            return .run { [array = state.array] send in
                await send(.internal(.sortingTimer(
                    await self.clock.measure {
                        await send(.internal(.mergeSortResult(TaskResult {
                            await self.sortingAlgorithms.mergeSort(array.values)
                        }
                                                             )
                                            )
                        )
                    }
                )))
            }
            .animation()
        case let .internal(.mergeSortResult(.success(data))):
            state.array.values = data
            return .none
            
        case .internal(.mergeSortResult(.failure)):
            print("fail")
            return .none
            
        case .internal(.onAppear):
            state.array.values = self.elementGenerator.generateElements(20)
            return .none
            
        case .internal(.bubbleSortTapped):
            state.timer = .zero
            return .run { [array = state.array] send in
                await send(.internal(.sortingTimer(
                    await self.clock.measure {
                        await send(.internal(.bubbleSortResult(TaskResult {
                            await self.sortingAlgorithms.bubbleSort(array.values)
                        }
                                                             )
                                            )
                        )
                    }
                )))
            }
            .animation()
        case let .internal(.bubbleSortResult(.success(data))):
            state.array.values = data
            return .none
        case .internal(.bubbleSortResult(.failure(_))):
            print("BUBBLE FAIL")
            return .none
        }
    }
}
