import Foundation
import IdentifiedCollections
import UnsortedElements
import AsyncExtensions

public struct SortingAlgorithms: Sendable {
    public typealias MergeSortInput = @Sendable (UnsortedElements) async -> UnsortedElements
    public typealias MergeSortOutput = @Sendable () async -> AnyAsyncSequence<[UnsortedElements.Element]>
    public typealias BubbleSort = @Sendable (UnsortedElements) async -> Void
    public typealias BubbleSortReceiver = @Sendable () async -> AnyAsyncSequence<[UnsortedElements.Element]?>

    public var mergeSort: MergeSortInput
    public var mergeSortOutput: MergeSortOutput
    public var bubbleSort: BubbleSort
    public var bubbleSortReceiver: BubbleSortReceiver
}
