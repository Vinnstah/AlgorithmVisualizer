import ComposableArchitecture
import Foundation
import HomeFeature
import SortingFeature

public extension App {
    var body: some Reducer<State, Action> {
        CombineReducers {
            Scope(state: \State.home, action: /Action.home) {
                Home()
            }
            Scope(state: \State.sorting, action: /Action.sorting) {
                Sorting()
            }
            Reduce { state, action in
                switch action {
                case let .selectedTabChanged(tab):
                    state.selectedTab = tab
                    return .none
                    
                case .home(_):
                    return .none
                case .sorting(_):
                    return .none
                }
            }
        }
    }
//    func reduce(into state: inout State, action: Action) -> Effect<Action> {
//        switch action {
//
//        case let .selectedTabChanged(tab):
//            state.selectedTab = tab
//            return .none
//
//        case .home(_):
//            return .none
//        case .sorting(_):
//            return .none
//        }
//    }
}
