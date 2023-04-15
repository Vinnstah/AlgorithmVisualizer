import Foundation
import Node
import Grid
    
    public func _breatdhFirstSearch(
        grid: inout Grid,
        node: inout Node,
        visitedNodes: inout [Node],
        queue: inout Queue
    ) -> Void {
        
        guard !node.isEndNode && !queue.elements.isEmpty else {
            visitedNodes.append(node)
            return
        }
        
        while !queue.elements.isEmpty && !visitedNodes.contains(where: { $0 == node }) {
            visitedNodes.append(node)
            for neighbor in node.neighbors {
                if visitedNodes.contains(where: { $0 == grid.nodes[neighbor]}) {
                    continue
                }
                queue.addLast(node: grid.nodes[neighbor])
            }
            queue.popFirst()
            node = queue.elements[0]
            return _breatdhFirstSearch(grid: &grid, node: &node, visitedNodes: &visitedNodes, queue: &queue)
        }
        queue.popFirst()
        guard !queue.elements.isEmpty else {
            return
        }
        node = queue.elements[0]
        return _breatdhFirstSearch(grid: &grid, node: &node, visitedNodes: &visitedNodes, queue: &queue)
    }
