import ComposableArchitecture
import Foundation

public extension Pathfinding {
    
    var body: some Reducer<State, Action> {
        Reduce { state, action in
            switch action {
            case .onAppear:
                print(state.grid)
                return .none
            }
        }
    }
}
