import ComposableArchitecture
import Foundation
import Grid
import Node

public extension Pathfinding {
    
    var body: some Reducer<State, Action> {
        Reduce { state, action in
            switch action {
                
            case .view(.appeared):
                return .none
                
            case .view(.bfsTapped):
                return performBreadthFirstSearch(state: &state)
                
            case let .pathfindingValueResponse(node):
                
                guard !node.isEndNode else {
                    var shortestPath: [Node] = []
                    shortestPath.append(node)
                    state.shortestPath = calculateShortestPath(shortestPath: &shortestPath, node: node, grid: state.grid)
                    state.pathfindingInProgress = false
                    return .none
                        .animation()
                }
                
                state.visitedNodes.append(node)
                return .none
                    .animation()
            case let .pathfindingAnimationDelayTapped(delay):
                state.pathfindingAnimationDelay = delay
                return .none
            }
        }
    }
}

extension Pathfinding {
    
    public func calculateShortestPath(
        shortestPath: inout [Node],
        node: Node,
        grid: Grid
    ) -> [Node] {
        
        guard !node.isStartingNode else {
            return shortestPath
        }
        
        shortestPath.append(grid.nodes[node.neighbors[0]])
        return calculateShortestPath(shortestPath: &shortestPath, node: grid.nodes[node.neighbors[0]], grid: grid)
    }
}

private enum CancelID: Hashable {
    case pathfinding
}

extension Pathfinding {
    
    public func performBreadthFirstSearch(
        state: inout State
    ) -> Effect<Action> {
        
        state.pathfindingInProgress = true
        
        var queue: Queue = .init(elements: [state.grid.nodes[0]])
        var listOfAllVisitedNodes: [Node] = []
        var grid = state.grid
        var firstNode = queue.elements[0]
        
        pathfindingClient.breadthFirstSearch(
            &grid,
            &firstNode,
            &listOfAllVisitedNodes,
            &queue
        )
        
        return .run { [visitedNodes = listOfAllVisitedNodes, delay = state.pathfindingAnimationDelay] send in
            for node in visitedNodes {
                await send(.pathfindingValueResponse(node), animation: .default)
                try await Task.sleep(for: .milliseconds(delay))
            }
        }
        .animation()
        .cancellable(id: CancelID.pathfinding)
    }
}
