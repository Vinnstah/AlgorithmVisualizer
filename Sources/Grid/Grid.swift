import Foundation
import Node

public struct Grid: Equatable {
    public static func == (lhs: Grid, rhs: Grid) -> Bool {
        lhs.nodes[0].id == rhs.nodes[0].id
    }
    
    public var nodes: [Node]
    public let onTap: () -> Void
    
    public init(nodes: [Node], onTap: @escaping () -> Void = {} ) {
        self.nodes = nodes
        self.onTap = onTap
    }
    
    
    public mutating func markNodeAsChecked(node: Node) -> Void {
        self.nodes[getIndex(node: node)].hasNodeBeenChecked = true
    }
    
    public func getIndex(node: Node) -> Int {
        return self.nodes.firstIndex(where: { $0.id == node.id}) ?? -1
    }
}

public struct Queue: Equatable, Hashable {
    public var elements: [Node]
    
    public init(elements: [Node] = []) {
        self.elements = elements
    }
    
    public mutating func popFirst() {
        self.elements.remove(at: 0)
    }
    
    public mutating func addLast(node: Node) {
        self.elements.append(node)
    }
}

//public struct Deca<Element> {
//    public var first: Element
//       public var second: Element
//       public var third: Element
//       public var fourth: Element
//       public var fifth: Element
//       public var sixth: Element
//       public var seventh: Element
//       public var eight: Element
//       public var ninth: Element
//       public var tenth: Element
//
//    public init(first: Element, second: Element, third: Element, fourth: Element, fifth: Element, sixth: Element, seventh: Element, eight: Element, ninth: Element, tenth: Element) {
//        self.first = first
//        self.second = second
//        self.third = third
//        self.fourth = fourth
//        self.fifth = fifth
//        self.sixth = sixth
//        self.seventh = seventh
//        self.eight = eight
//        self.ninth = ninth
//        self.tenth = tenth
//    }
//
//    public init(element: Element) {
//        self.first = element
//        self.second = element
//        self.third = element
//        self.fourth = element
//        self.fifth = element
//        self.sixth = element
//        self.seventh = element
//        self.eight = element
//        self.ninth = element
//        self.tenth = element
//    }
//}
//
//extension Deca: Equatable where Element: Equatable {}
//extension Deca: Codable where Element: Codable {}
//extension Deca: Hashable where Element: Hashable {}
//extension Deca: RandomAccessCollection {}
//
//extension Deca: MutableCollection {
//    public subscript(offset: Int) -> Element {
//        _read {
//            switch offset {
//            case 0: yield self.first
//            case 1: yield self.second
//            case 2: yield self.third
//            case 3: yield self.fourth
//            case 4: yield self.fifth
//            case 5: yield self.sixth
//            case 6: yield self.seventh
//            case 7: yield self.eight
//            case 8: yield self.ninth
//            case 9: yield self.tenth
//            default: fatalError()
//            }
//        }
//        _modify {
//            switch offset {
//            case 0: yield &self.first
//            case 1: yield &self.second
//            case 2: yield &self.third
//            case 3: yield &self.fourth
//            case 4: yield &self.fifth
//            case 5: yield &self.sixth
//            case 6: yield &self.seventh
//            case 7: yield &self.eight
//            case 8: yield &self.ninth
//            case 9: yield &self.tenth
//            default: fatalError()
//            }
//        }
//    }
//
//    public var startIndex: Int { 0 }
//    public var endIndex: Int { 9 }
//    public func index(after i: Int) -> Int { i + 1 }
//}

//public struct Grid: Identifiable, Equatable {
//    public let rows: [Row]
//    public var id: UUID
//
//    public init(rows: [Row], id: UUID) {
//        self.rows = rows
//        self.id = id
//    }
//
//    public struct Row: Equatable, Identifiable {
//        public let row: [Column]
//        public var id: Range<Int> {
//            self.row.indices
//        }
//
//        public init(row: [Column]) {
//            self.row = row
//        }
//
//        public struct Column: Equatable, Identifiable {
//            public let node: Node
//            public var id: UUID {
//                self.node.id
//            }
//
//            public init(node: Node) {
//                self.node = node
//            }
//        }
//    }
//}

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

