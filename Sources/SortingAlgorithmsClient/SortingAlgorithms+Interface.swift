import Foundation
import IdentifiedCollections
import UnsortedElements

public struct SortingAlgorithms {
    public typealias MergeSortInput = @Sendable (UnsortedElements) async -> UnsortedElements
    public typealias BubbleSortInput = @Sendable (UnsortedElements) async -> UnsortedElements

    public let mergeSort: MergeSortInput
    public let bubbleSort: BubbleSortInput
}
