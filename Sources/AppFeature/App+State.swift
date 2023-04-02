import ComposableArchitecture
import HomeFeature
import SortingFeature
import PathfindingFeature

public struct App: Reducer {
    public init() {}
}

public extension App {
    struct State: Equatable {
        public var sorting: Sorting.State
        public var home: Home.State
        public var selectedTab: Tab
        public var pathfinding: Pathfinding.State

        public init(
            sorting: Sorting.State = .init(),
            home: Home.State = .init(),
            selectedTab: Tab = .home,
            pathfinding: Pathfinding.State = .init()
        ) {
            self.sorting = sorting
            self.home = home
            self.selectedTab = selectedTab
            self.pathfinding = pathfinding
        }
    }
}

public enum Tab: Equatable {
    case sorting, home, search, pathfinding
}
