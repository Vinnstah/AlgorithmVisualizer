import ComposableArchitecture
import Foundation
import Grid
import Node

public extension Pathfinding {
    
    var body: some Reducer<State, Action> {
        Reduce { state, action in
            switch action {
            case .onAppear:
                return .none
            case .bfs:
                var queue: Queue = .init(elements: [state.grid.nodes[0]])
                var listOfAllVisitedNodes: [Node] = []
                var grid = state.grid
                var firstNode = queue.elements[0]
                
                breatdhFirstSearch(
                    grid: &grid,
                    node: &firstNode,
                    visitedNodes: &state.visitedNodes,
                    queue: &queue
                ) { nodes in
                    listOfAllVisitedNodes = nodes
                }
                return .run { [visitedNodes = listOfAllVisitedNodes, delay = state.pathfindingAnimationDelay] send in
                    for node in visitedNodes {
//                                                try await Task.sleep(for: .milliseconds(delay))
                        await send(.pathfindingValueResponse(node))
                    }
                }
                .animation()
                .cancellable(id: CancelID.pathfinding)
                
            case let .pathfindingValueResponse(node):
                
                guard !node.isEndNode else {
                    var shortestPath: [Node] = []
                    shortestPath.append(node)
                    state.shortestPath = appendNeighbors(shortestPath: &shortestPath, node: node, grid: state.grid)
                    return .none
                        .animation()
                }
                state.grid.nodes[state.grid.getIndex(node: node)] = node
                return .none
            }
        }
    }
}

public func appendNeighbors(shortestPath: inout [Node], node: Node, grid: Grid) -> [Node] {
    guard !node.isStartingNode else {
        return shortestPath
    }
    shortestPath.append(grid.nodes[node.neighbors[0]])
    return appendNeighbors(shortestPath: &shortestPath, node: grid.nodes[node.neighbors[0]], grid: grid)
}
private enum CancelID: Hashable {
    case pathfinding
}


public func breatdhFirstSearch(
    grid: inout Grid,
    node: inout Node,
    visitedNodes: inout [Node],
    queue: inout Queue,
    callback: ([Node]) -> Void) -> Node {
        
        guard !node.isEndNode && !queue.elements.isEmpty else {
            visitedNodes.append(node)
            callback(visitedNodes)
            return node
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
            return breatdhFirstSearch(grid: &grid, node: &node, visitedNodes: &visitedNodes, queue: &queue, callback: callback)
        }
        queue.popFirst()
        guard !queue.elements.isEmpty else {
            callback(visitedNodes)
            return node
        }
        node = queue.elements[0]
        return breatdhFirstSearch(grid: &grid, node: &node, visitedNodes: &visitedNodes, queue: &queue, callback: callback)
    }
