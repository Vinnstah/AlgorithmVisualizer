import ComposableArchitecture
import Foundation
import HomeFeature
import SortingFeature

public extension App {
    enum Action: Equatable {
        case sorting(Sorting.Action)
        case home(Home.Action)
        case selectedTabChanged(Tab)
    }
}
