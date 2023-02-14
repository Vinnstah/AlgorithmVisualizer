import Foundation
import ComposableArchitecture
import SortingFeature

public extension App {
    enum Action: Equatable {
        case sorting(Sorting.Action)
        case selectedTabChanged(Tab)
    }
}
