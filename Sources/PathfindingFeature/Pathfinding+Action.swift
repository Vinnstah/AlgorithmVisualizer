import ComposableArchitecture
import Foundation
import Node
import Grid

public extension Pathfinding {
    enum Action: Equatable {
        case view(ViewAction)
        case pathfindingValueResponse(Node)
        case pathfindingAnimationDelayTapped(Double)
        
       public enum ViewAction: Equatable {
            case bfsTapped
            case appeared
            
        }
    }
}
