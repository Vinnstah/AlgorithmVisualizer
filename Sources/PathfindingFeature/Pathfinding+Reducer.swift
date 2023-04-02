import ComposableArchitecture
import Foundation

public extension Pathfinding {
    
    var body: some Reducer<State, Action> {
        Reduce { state, action in
            switch action {
            case .onAppear:
                print("1")
                print(state.grid)
                return .none
            }
        }
    }
}
