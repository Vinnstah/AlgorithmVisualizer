import ComposableArchitecture
import Foundation
import Node
import Grid

public extension Pathfinding {
    enum Action: Equatable {
//        enum View: Equatable
        case onAppear
        case bfs
        case pathfindingValueResponse(Node)
        case pathfindingAnimationDelayTapped(Double)
    }
}
