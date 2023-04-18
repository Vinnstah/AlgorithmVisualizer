import Dependencies
import Foundation

#if DEBUG
    import XCTestDynamicOverlay

    public extension PathfindingClient {
        static let test = Self(
            breadthFirstSearch: unimplemented("BFS"),
            depthFirstSearch: unimplemented("BFS"))
    }

    extension PathfindingClient: TestDependencyKey {
        public static let testValue = PathfindingClient.test
    }
#endif

public extension DependencyValues {
    var pathfindingClient: PathfindingClient {
        get { self[PathfindingClient.self] }
        set { self[PathfindingClient.self] = newValue }
    }
}
