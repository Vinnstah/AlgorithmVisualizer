import Foundation
import Node

public struct Grid: Identifiable, Equatable {
    public let rows: [Row]
    public var id: UUID
    
    public init(rows: [Row], id: UUID) {
        self.rows = rows
        self.id = id
    }
    
    public struct Row: Equatable, Identifiable {
        public let row: [Column]
        public var id: Range<Int> {
            self.row.indices
        }
        
        public init(row: [Column]) {
            self.row = row
        }
        
        public struct Column: Equatable, Identifiable {
            public let node: Node
            public var id: UUID {
                self.node.id
            }
            
            public init(node: Node) {
                self.node = node
            }
        }
    }
}

//public struct Grid<Element: Identifiable & Equatable>: Identifiable, Equatable {
//    public static func == (lhs: Grid<Element>, rhs: Grid<Element>) -> Bool {
//        lhs.id == rhs.id
//    }
//
//    public let row: Row<Element>
//    public let id: UUID
//    public let count: Int
//
//    public init(
//        row: Row<Element>,
//        id: UUID = .init(),
//        count: Int = 0
//    ) {
//        self.row = row
//        self.id = id
//        self.count = count
//    }
//
//    public struct Row<Element> {
//        public var row: [Element]
//
//        public init(
//            row: [Element] = .init(repeating: Element, count: 2)
//        ) {
//            self.row = row
//        }
//
//    }
//
////    var grid: Grid<Grid<Node>>
//}
//
//public var grid = Grid<Grid<Node>>

