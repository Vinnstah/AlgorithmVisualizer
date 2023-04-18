import Foundation
import IdentifiedCollections
import Dependencies

public struct Node: Hashable, Identifiable {
    
    public let id: UUID
    public var isStartingNode: Bool
    public var isEndNode: Bool
    public var blocked: Bool?
    public var neighbors: [Int]
    public var hasNodeBeenChecked: Bool
    
    public init(id: UUID, isStartingNode: Bool, isEndNode: Bool, blocked: Bool?, neighbors: [Int], hasNodeBeenChecked: Bool = false) {
        self.id = id
        self.isStartingNode = isStartingNode
        self.isEndNode = isEndNode
        self.blocked = blocked
        self.neighbors = neighbors
        self.hasNodeBeenChecked = hasNodeBeenChecked
    }
    
}
public func nodeGenerator(count: Int) -> IdentifiedArrayOf<Node> {
    
    @Dependency(\.uuid) var uuid
    
    var nodeList: IdentifiedArrayOf<Node> = []
//    let endNode: Int = 90
    let endNode: Int = count-Int.random(in: 1...15)
    
    for i in 0...count-1 {
        nodeList.append(
            Node(
                id: uuid.callAsFunction(),
                isStartingNode: i == 0 ? true : false ,
                isEndNode: i == endNode ? true : false ,
//                blocked: { i == 50 ? true : false}(),
                blocked: { i % 4 == 0 ? true : false}(),
                neighbors: getNeighbors(index: i, count: count)
            )
        )
    }
    return nodeList
}

public func getNeighbors(index: Int, count: Int) -> [Int] {
    
    let leftEdge: Set<Int> = Set(9...count-11).filter { $0 % 10 == 0 }
    let rightEdge: Set<Int> = Set(9...count-11).filter { ($0 - 9) % 10 == 0 }
    let topEdge: Set<Int> = Set(1...8)
    let bottomEdge: Set<Int> = Set(count-9...count-1)
    let middleIndices: Set<Int> = Set(0...count-1).subtracting(leftEdge).subtracting(rightEdge).subtracting(topEdge).subtracting(bottomEdge)
    
    if index == 0 {
        return [index+1, index+10]
    }
    if index == count - 1 {
        return [index-10, index-1]
    }
    if index == 9 {
        return [index-1, index+10]
    }
    if index == count-10 {
        return [index-10, index+1]
    }
    if leftEdge.contains(index) {
        return [index-10, index+1, index+10]
    }
    if rightEdge.contains(index) {
        return [index-10, index-1, index+10]
    }
    if topEdge.contains(index) {
        return [index-1, index+1, index+10]
    }
    if bottomEdge.contains(index) {
        return [index-10, index-1, index+1]
    }
    if middleIndices.contains(index) {
        return [index-10, index-1, index+1, index+10]
    }
    return []
}
