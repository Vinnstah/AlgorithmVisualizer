import Grid
import Dependencies
import Node
import Foundation
import IdentifiedCollections

public struct PathfindingClient {
    
    public typealias BreadthFirstSearch = @Sendable (_ grid: inout Grid, _ node: inout Node, _ visitedNodes: inout IdentifiedArrayOf<Node>, _ queue: inout Queue) -> Void
    public typealias DepthFirstSearch = @Sendable (_ grid: inout Grid, _ node: inout Node, _ visitedNodes: inout IdentifiedArrayOf<Node>, _ queue: inout Queue) -> Void
    
    public var breadthFirstSearch: BreadthFirstSearch
    public var depthFirstSearch: DepthFirstSearch
    
}
