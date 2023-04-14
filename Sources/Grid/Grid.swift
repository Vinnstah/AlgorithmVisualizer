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
