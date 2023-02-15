import Foundation
import ComposableArchitecture
import SortingFeature
import HomeFeature

public extension App {
    enum Action: Equatable {
        case sorting(Sorting.Action)
        case home(Home.Action)
        case selectedTabChanged(Tab)
    }
}
