import ComposableArchitecture
import Foundation
import Grid
import Node
import PathfindingClient

public struct Pathfinding: Reducer {
    public init() {}
    @Dependency(\.pathfindingClient) var pathfindingClient
}

public extension Pathfinding {
    
    struct State: Equatable {
        public var grid: Grid
        public var visitedNodes: IdentifiedArrayOf<Node>
        public var pathfindingAnimationDelay: Double
        public var shortestPath: IdentifiedArrayOf<Node>
        public var pathfindingInProgress: Bool
        
        public init(
            grid: Grid = Grid(nodes: nodeGenerator(count: 100)),
            visitedNodes: IdentifiedArrayOf<Node> = [],
            pathfindingAnimationDelay: Double = 100,
            shortestPath: IdentifiedArrayOf<Node> = [],
            pathfindingInProgress: Bool = false
        ) {
            self.grid = grid
            self.visitedNodes = visitedNodes
            self.pathfindingAnimationDelay = pathfindingAnimationDelay
            self.shortestPath = shortestPath
            self.pathfindingInProgress = pathfindingInProgress
        }
    }
}

