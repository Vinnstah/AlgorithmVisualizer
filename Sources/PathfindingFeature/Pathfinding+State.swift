import ComposableArchitecture
import Foundation
import Grid
import Node

public struct Pathfinding: Reducer {
    public init() {}
}

public extension Pathfinding {
    
    struct State: Equatable {
        //        public var grid: [Node]
        //
        //        public init(grid: [Node] = nodeGenerator(count: 100))
        //        {
        //            self.grid = grid
        //        }
        
        public var grid: Grid
        public var checkedNodes: Set<UUID>
        
        public init(
            grid: Grid = Grid(grid: nodeGenerator(count: 100)),
            checkedNodes: Set<UUID> = []
        ) {
            self.grid = grid
            self.checkedNodes = checkedNodes
        }
    }
}

public struct Grid: Equatable {
    public static func == (lhs: Grid, rhs: Grid) -> Bool {
        lhs.grid[0].id == rhs.grid[0].id
    }
    
    var grid: [Node]
    let onTap: () -> Void
    
    public init(grid: [Node], onTap: @escaping () -> Void = {} ) {
        self.grid = grid
        self.onTap = onTap
    }
    
    public func getIndex(id: UUID) -> Int {
        return self.grid.firstIndex(where: { $0.id == id })!
    }
}
