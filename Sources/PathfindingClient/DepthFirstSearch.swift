import Node
import Foundation
import Grid
import IdentifiedCollections

public func _depthFirstSearch(
    grid: inout Grid,
    node: inout Node,
    visitedNodes: inout IdentifiedArrayOf<Node>,
    queue: inout Queue
) -> Void {
    
    
    guard !node.isEndNode && !queue.elements.isEmpty else {
        visitedNodes.append(node)
        return
    }
    
    while !queue.elements.isEmpty && !visitedNodes.contains(where: { $0 == node }) {
        
        
        for neighbor in node.neighbors.enumerated() {
            if grid.nodes[node.neighbors[neighbor.offset - 1]].blocked! {
                node.neighbors.remove(at: neighbor.offset - 1)
            }
            if visitedNodes.contains(where: { $0 == grid.nodes[node.neighbors[neighbor.offset - 1]] }) {
                node.neighbors.remove(at: neighbor.offset - 1)
            }
        }
        visitedNodes.append(node)
        
        if visitedNodes.contains(where: { $0 == grid.nodes[node.neighbors[0]]}) {
            queue.addLast(node: grid.nodes[node.neighbors[1]])
            print("QUQUQ \(queue)")
        }
//        if visitedNodes.contains(where: { $0 == grid.nodes[node.neighbors[1]]}) {
//            queue.addLast(node: grid.nodes[node.neighbors[1]])
//            print("QUQUQ \(queue)")
//        }
        else {
            queue.addLast(node: grid.nodes[node.neighbors[0]])
            print("SASASA \(queue)")
        }
        queue.popFirst()
        node = queue.elements[0]
        return _depthFirstSearch(grid: &grid, node: &node, visitedNodes: &visitedNodes, queue: &queue)
    }
    print("WWW")
    queue.popFirst()
    guard !queue.elements.isEmpty else {
        print("FFF")
        return
    }
    node = queue.elements[0]
    return _depthFirstSearch(grid: &grid, node: &node, visitedNodes: &visitedNodes, queue: &queue)
}
