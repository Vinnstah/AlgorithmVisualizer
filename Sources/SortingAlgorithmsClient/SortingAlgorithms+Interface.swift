import Foundation
import IdentifiedCollections
import UnsortedElements
import AsyncExtensions

public struct SortingAlgorithms: Sendable {
    public typealias MergeSortInput = @Sendable (UnsortedElements) async -> UnsortedElements
    public typealias MergeSortOutput = @Sendable () async -> AnyAsyncSequence<[UnsortedElements.Element]>
    public typealias BubbleSortOutput = @Sendable (UnsortedElements) async -> UnsortedElements
    public typealias BubbleSortReceiver = @Sendable () async -> AnyAsyncSequence<[UnsortedElements.Element]?>

    public var mergeSort: MergeSortInput
    public var mergeSortOutput: MergeSortOutput
    public var bubbleSortOutput: BubbleSortOutput
    public var bubbleSortReceiver: BubbleSortReceiver
}
