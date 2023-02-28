import Foundation
import IdentifiedCollections
import UnsortedElements
import AsyncExtensions

public struct SortingAlgorithms: Sendable {
    public typealias MergeSortInput = @Sendable (UnsortedElements) async -> UnsortedElements
    public typealias MergeSortOutput = @Sendable () async -> AnyAsyncSequence<[UnsortedElements.Element]>
    public typealias BubbleSortInput = @Sendable (UnsortedElements) async -> UnsortedElements
    public typealias BubbleSortOutput = @Sendable (UnsortedElements) async -> UnsortedElements
    public typealias BubbleSortReceiver = @Sendable () async -> AnyAsyncSequence<[Foo]?>

    public var mergeSort: MergeSortInput
    public var mergeSortOutput: MergeSortOutput
    public var bubbleSort: BubbleSortInput
    public var bubbleSortOutput: BubbleSortOutput
    public var bubbleSortReceiver: BubbleSortReceiver
}
//public struct SortingAlgorithms: Sendable {
//    public typealias MergeSortInput = @Sendable (UnsortedElements) async -> UnsortedElements
//    public typealias BubbleSortInput = @Sendable (UnsortedElements) async -> UnsortedElements
//
//    public var mergeSort: MergeSortInput
//    public var bubbleSort: BubbleSortInput
//}
