import Foundation
import IdentifiedCollections
import UnsortedElements
import AsyncExtensions

public struct SortingAlgorithms: Sendable {
    public typealias MergeSort = @Sendable (UnsortedElements,_ callback: ([UnsortedElements]) -> Void) -> Void
    public typealias BubbleSort = @Sendable (UnsortedElements,_ callback: ([UnsortedElements]) -> Void) -> Void
    public typealias SelectionSort = @Sendable (inout UnsortedElements,_ callback: ([UnsortedElements]) -> Void) -> Void
    public typealias InsertionSort = @Sendable (inout UnsortedElements,_ callback: ([UnsortedElements]) -> Void) -> Void

    public var mergeSort: MergeSort
    public var bubbleSort: BubbleSort
    public var selectionSort: SelectionSort
    public var insertionSort: InsertionSort
}
