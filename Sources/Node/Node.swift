import Foundation

public struct Node: Hashable, Identifiable {
    
    public let id: UUID
    public let isStartingNode: Bool
    public let isEndNode: Bool
    public let blocked: Bool?
    public let neighbors: Set<Int>
    
    //    public struct Distance: Hashable {
    //        public let value: Double
    //
    //        public init(value: Double) {
    //            self.value = value
    //        }
    //    }
    
    public init(id: UUID, isStartingNode: Bool, isEndNode: Bool, blocked: Bool?, neighbors: Set<Int>) {
        self.id = id
        self.isStartingNode = isStartingNode
        self.isEndNode = isEndNode
        self.blocked = blocked
        self.neighbors = neighbors
    }
    
}
public func nodeGenerator(count: Int) -> [Node] {
    var nodeList: [Node] = []
    for i in 0...count-1 {
        nodeList.append(
            Node(
                id: .init(),
                isStartingNode: i == 0 ? true : false ,
                isEndNode: i == count-1 ? true : false ,
                blocked: nil,
                neighbors: getNeighbors(iteration: i, count: count)
            )
        )
    }
    return nodeList
}

public func getNeighbors(iteration: Int, count: Int) -> Set<Int> {
   let leftEdge: Set<Int> = Set(9...count-11).filter { $0 % 10 == 0 }
   let rightEdge: Set<Int> = Set(9...count-11).filter { ($0 - 9) % 10 == 0 }
   let topEdge: Set<Int> = Set(1...8)
   let bottomEdge: Set<Int> = Set(count-9...count-1)
   let middleIndices: Set<Int> = Set(0...count-1).subtracting(leftEdge).subtracting(rightEdge).subtracting(topEdge).subtracting(bottomEdge)
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
