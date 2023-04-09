import ComposableArchitecture
import Foundation
import Node
import Grid

public extension Pathfinding {
    enum Action: Equatable {
        case onAppear
        case bfs
        case pathfindingValueResponse(Node)
    }
}
