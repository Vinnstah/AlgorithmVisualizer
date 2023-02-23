import Foundation
import IdentifiedCollections
import UnsortedElements

public struct SortingAlgorithms: Sendable {
    public typealias MergeSortInput = @Sendable (UnsortedElements) async -> UnsortedElements
    public typealias BubbleSortInput = @Sendable (UnsortedElements) async -> UnsortedElements

    public var mergeSort: MergeSortInput
    public var bubbleSort: BubbleSortInput
}
