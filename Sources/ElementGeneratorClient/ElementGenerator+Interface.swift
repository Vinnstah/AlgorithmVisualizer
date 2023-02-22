import Foundation
import UnsortedElements

public struct ElementGenerator: Sendable {
    public typealias Generate = @Sendable (UInt) async -> UnsortedElements

    public var generate: Generate
}
