import Dependencies
import Foundation

extension PathfindingClient: DependencyKey {
    public static var liveValue: PathfindingClient {
        return Self(
            breadthFirstSearch: { grid, node, visitedNodes, queue in
                return _breatdhFirstSearch(grid: &grid, node: &node, visitedNodes: &visitedNodes, queue: &queue)
            })
        
    }
    }
