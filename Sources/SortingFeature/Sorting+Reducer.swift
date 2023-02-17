import ComposableArchitecture
import Foundation

public extension Sorting {
    func reduce(into state: inout State, action: Action) -> Effect<Action> {
        switch action {
        case .onAppear:
//            state.array.addRandomElementsToArray(count: state.arraySize)
            return .none
            
        case let .arraySizeStepperTapped(value):
            state.arraySize = value
            return .none
            
        case .internal(.arraySizeChanged):
            state.array.addRandomElementsToArray(count: state.arraySize)
            return .none
        }
    }
}
