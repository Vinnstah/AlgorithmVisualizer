import Foundation

public struct Node: Hashable, Identifiable {
    
    public let id: UUID
    public let start: Bool?
    public let end: Bool?
    public let blocked: Bool?
    public let neighbors: [Node: Distance]
    
    public struct Distancec: Hashable {
        public let value: Double
    }
    
}
