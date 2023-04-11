import ComposableArchitecture
import Foundation
import Grid
import Node

public struct Pathfinding: Reducer {
    public init() {}
}

public extension Pathfinding {
    
    struct State: Equatable {
        public var grid: Grid
        public var visitedNodes: [Node]
        public var pathfindingAnimationDelay: Double
        public var shortestPath: [Node]
        public var pathfindingInProgress: Bool
        
        public init(
            grid: Grid = Grid(nodes: nodeGenerator(count: 100)),
            visitedNodes: [Node] = [],
            pathfindingAnimationDelay: Double = 100,
            shortestPath: [Node] = [],
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

