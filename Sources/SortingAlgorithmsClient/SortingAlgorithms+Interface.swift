import Foundation
import IdentifiedCollections
import UnsortedElements
import AsyncExtensions

public struct SortingAlgorithms: Sendable {
    public typealias MergeSort = @Sendable (UnsortedElements) async -> Void
    public typealias MergeSortReceiver = @Sendable () async -> AnyAsyncSequence<[UnsortedElements.Element]?>
    public typealias BubbleSort = @Sendable (UnsortedElements) async -> Void
    public typealias BubbleSortReceiver = @Sendable () async -> AnyAsyncSequence<[UnsortedElements.Element]?>

    public var mergeSort: MergeSort
    public var mergeSortReceiver: MergeSortReceiver
    public var bubbleSort: BubbleSort
    public var bubbleSortReceiver: BubbleSortReceiver
}
