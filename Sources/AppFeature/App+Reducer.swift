import ComposableArchitecture
import Foundation

public extension App {
    func reduce(into state: inout State, action: Action) -> Effect<Action> {
        switch action {
        case let .selectedTabChanged(tab):
            state.selectedTab = tab
            return .none
        }
    }
}
