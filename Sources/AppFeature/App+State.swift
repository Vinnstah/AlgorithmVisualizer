import ComposableArchitecture
import SortingFeature

public struct App: Reducer {
    public init() {}
}

public extension App {
    struct State: Equatable {
        public var sorting: Sorting.State
        public var selectedTab: Tab
        
        public init(
            sorting: Sorting.State = .init(),
            selectedTab: Tab = .sorting
        ) {
            self.sorting = sorting
            self.selectedTab = selectedTab
        }
    }
}

public enum Tab: Equatable {
    case sorting
}
