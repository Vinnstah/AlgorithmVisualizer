import Foundation
import UnsortedElements

public struct ElementGenerator: Sendable {
    public typealias Generate = @Sendable (UInt) -> UnsortedElements

    public var generate: Generate
}
