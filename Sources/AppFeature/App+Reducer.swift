import ComposableArchitecture
import Foundation
import HomeFeature
import SortingFeature
import PathfindingFeature

public extension App {
    var body: some Reducer<State, Action> {
        CombineReducers {
            Scope(state: \State.home, action: /Action.home) {
                Home()
            }
            Scope(state: \State.sorting, action: /Action.sorting) {
                Sorting()
            }
            Scope(state: \State.pathfinding, action: /Action.pathfinding) {
                Pathfinding()
            }
            Reduce { state, action in
                switch action {
                case let .selectedTabChanged(tab):
                    state.selectedTab = tab
                    return .none

                case .home:
                    return .none
                case .sorting:
                    return .none
                case .pathfinding:
                    return .none
                }
            }
        }
    }
}
