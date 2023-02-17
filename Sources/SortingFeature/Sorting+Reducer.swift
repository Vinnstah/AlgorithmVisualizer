import ComposableArchitecture
import Foundation
import ChartModel

public extension Sorting {
    func reduce(into state: inout State, action: Action) -> Effect<Action> {
        switch action {
            
        case let .internal(.arraySizeStepperTapped(value)):
            state.array.count = value
            return .none
            
        case .internal(.mergeSortTapped):
            return .run { [array = state.array] send in
                await send(.internal(.mergeSortResult(TaskResult {
                    await self.sortingAlgorithms.mergeSort(array.values)
                }
                                                     )
                                    )
                )
            }
            .animation()
        case let .internal(.mergeSortResult(.success(data))):
            state.array.values = data
            return .none
            
        case .internal(.mergeSortResult(.failure)):
            print("fail")
            return .none
            
        case .internal(.onAppear):
            state.array.values = state.array.addRandomElementsToArray()
            return .none
        }
    }
}
