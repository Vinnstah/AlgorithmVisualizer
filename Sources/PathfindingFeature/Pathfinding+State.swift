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
        
        public init(grid: Grid = Grid(rows:
                .init(repeating: .init(row:
                        .init(repeating:
                                .init(node: Node(id: .init(), isStartingNode: true, isEndNode: false, blocked: nil, neighbors: [:])), count: 5)), count: 5), id: .init())
                    
        ) {
            self.grid = grid
        }
    }
}
