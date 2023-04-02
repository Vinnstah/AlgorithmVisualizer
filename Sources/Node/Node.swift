import Foundation

public struct Node: Hashable, Identifiable {
    
    public let id: UUID
    public let isStartingNode: Bool
    public let isEndNode: Bool
    public let blocked: Bool?
    public let neighbors: [Node: Distance]
    
    public struct Distance: Hashable {
        public let value: Double
        
        public init(value: Double) {
            self.value = value
        }
    }
    
    public init(id: UUID, isStartingNode: Bool, isEndNode: Bool, blocked: Bool?, neighbors: [Node : Distance]) {
        self.id = id
        self.isStartingNode = isStartingNode
        self.isEndNode = isEndNode
        self.blocked = blocked
        self.neighbors = neighbors
    }
}
