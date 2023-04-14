import Grid
import Dependencies
import Node
import Foundation


public struct PathfindingClient {
    public typealias BreadthFirstSearch = @Sendable (_ grid: inout Grid, _ node: inout Node, _ visitedNodes: inout [Node], _ queue: inout Queue) -> Node
    
    public let breadthFirstSearch: BreadthFirstSearch
    
}
