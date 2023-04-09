import Foundation

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
public func nodeGenerator(count: Int) -> [Node] {
    var nodeList: [Node] = []
    var endNode: Int = count-Int.random(in: 1...15)
    for i in 0...count-1 {
        nodeList.append(
            Node(
                id: .init(),
                isStartingNode: i == 0 ? true : false ,
                isEndNode: i == endNode ? true : false ,
                blocked: nil,
                neighbors: getNeighbors(iteration: i, count: count)
            )
        )
    }
    return nodeList
}

public func getNeighbors(iteration: Int, count: Int) -> [Int] {
   let leftEdge: Set<Int> = Set(9...count-11).filter { $0 % 10 == 0 }
   let rightEdge: Set<Int> = Set(9...count-11).filter { ($0 - 9) % 10 == 0 }
   let topEdge: Set<Int> = Set(1...8)
   let bottomEdge: Set<Int> = Set(count-9...count-1)
   let middleIndices: Set<Int> = Set(0...count-1).subtracting(leftEdge).subtracting(rightEdge).subtracting(topEdge).subtracting(bottomEdge)
    if iteration == 0 {
        return [iteration+1, iteration+10]
    }
    if iteration == count - 1 {
        return [iteration-10, iteration-1]
    }
    if iteration == 9 {
        return [iteration-1, iteration+10]
    }
    if iteration == count-10 {
        return [iteration-10, iteration+1]
    }
    if leftEdge.contains(iteration) {
        return [iteration-10, iteration+1, iteration+10]
    }
        if rightEdge.contains(iteration) {
            return [iteration-10, iteration-1, iteration+10]
        }
        if topEdge.contains(iteration) {
            return [iteration-1, iteration+1, iteration+10]
        }
        if bottomEdge.contains(iteration) {
            return [iteration-10, iteration-1, iteration+1]
        }
        if middleIndices.contains(iteration) {
            return [iteration-10, iteration-1, iteration+1, iteration+10]
        }
    return []
}
