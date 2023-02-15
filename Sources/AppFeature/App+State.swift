import ComposableArchitecture
import SortingFeature
import HomeFeature

public struct App: Reducer {
    public init() {}
}

public extension App {
    struct State: Equatable {
        public var sorting: Sorting.State
        public var home: Home.State
        public var selectedTab: Tab
        
        public init(
            sorting: Sorting.State = .init(),
            home: Home.State = .init(),
            selectedTab: Tab = .home
        ) {
            self.sorting = sorting
            self.home = home
            self.selectedTab = selectedTab
        }
    }
}

public enum Tab: Equatable {
    case sorting, home, search, pathfinding
}
