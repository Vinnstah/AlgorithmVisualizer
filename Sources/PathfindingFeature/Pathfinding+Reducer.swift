import ComposableArchitecture
import Foundation
import Grid
import Node
import PathfindingClient

public extension Pathfinding {
    
    var body: some Reducer<State, Action> {
        Reduce { state, action in
            switch action {
                
            case .view(.appeared):
                return .none
                
            case .view(.bfsTapped):
                return performPathfindAlgorithm(state: &state, algorithm: .breadthFirstSearch(pathfindingClient))
                
            case let .pathfindingValueResponse(node):
                
                guard !node.isEndNode else {
                    
                    var shortestPath: IdentifiedArrayOf<Node> = .init(arrayLiteral: node)
                    
                    state.visitedNodes.append(node)
                    state.shortestPath = calculateShortestPath(shortestPath: &shortestPath, node: node, grid: state.grid)
                    state.pathfindingInProgress = false
                    
                    return .none
                }
                
                state.visitedNodes.append(node)
                return .none
                
            case let .pathfindingAnimationDelayTapped(delay):
                state.pathfindingAnimationDelay = delay
                return .none
                
            case .view(.dfsTapped):
                return performPathfindAlgorithm(state: &state, algorithm: .depthFirstSearch(pathfindingClient))
                
            case .view(.resetGridTapped):
                state.pathfindingInProgress = false
                state.visitedNodes = []
                state.shortestPath = []
                
                return .cancel(id: CancelID.pathfinding)
                    .animation()
            }
        }
    }
}

extension Pathfinding {
    
    public func calculateShortestPath(
        shortestPath: inout IdentifiedArrayOf<Node>,
        node: Node,
        grid: Grid
    ) -> IdentifiedArrayOf<Node> {
        
        guard !node.isStartingNode else {
            return shortestPath
        }
        
        guard let notBlockedNeighbor == !grid.nodes[node.neighbors[0]].blocked else {
            fatalError()
        }
//        guard (grid.nodes[node.neighbors[0]].blocked == false) else {
//            guard (grid.nodes[node.neighbors[1]].blocked == false) else {
//                guard (grid.nodes[node.neighbors[2]].blocked == false) else {
//                    shortestPath.append(grid.nodes[node.neighbors[3]])
//                    return calculateShortestPath(
//                        shortestPath: &shortestPath,
//                        node: grid.nodes[node.neighbors[3]],
//                        grid: grid
//                    )
//                }
//                shortestPath.append(grid.nodes[node.neighbors[2]])
//                return calculateShortestPath(
//                    shortestPath: &shortestPath,
//                    node: grid.nodes[node.neighbors[2]],
//                    grid: grid
//                )
//            }
//            shortestPath.append(grid.nodes[node.neighbors[1]])
//            return calculateShortestPath(
//                shortestPath: &shortestPath,
//                node: grid.nodes[node.neighbors[1]],
//                grid: grid
//            )
//        }
        
        shortestPath.append(grid.nodes[node.neighbors[0]])
        
        return calculateShortestPath(
            shortestPath: &shortestPath,
            node: grid.nodes[node.neighbors[0]],
            grid: grid
        )
    }
}

private enum CancelID: Hashable {
    case pathfinding
}

extension Pathfinding {
    
    public func performPathfindAlgorithm(
        state: inout State,
        algorithm: PathfindingAlgortihms
    ) -> Effect<Action> {
        
        state.pathfindingInProgress = true
        
        var queue: Queue = .init(elements: [state.grid.nodes[0]])
        var listOfAllVisitedNodes: IdentifiedArrayOf<Node> = []
        var grid = state.grid
        var firstNode = queue.elements[0]
        
        switch algorithm {
        case let .breadthFirstSearch(pathfindingClient): pathfindingClient.breadthFirstSearch(
            &grid,
            &firstNode,
            &listOfAllVisitedNodes,
            &queue
        )
        case let .depthFirstSearch(pathfindingClient): pathfindingClient.depthFirstSearch(
            &grid,
            &firstNode,
            &listOfAllVisitedNodes,
            &queue
        )
        }
        
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

public enum PathfindingAlgortihms {
    case breadthFirstSearch(PathfindingClient)
    case depthFirstSearch(PathfindingClient)
}
