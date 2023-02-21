import Foundation
import ChartModel
import IdentifiedCollections

public struct SortingAlgorithms {
    public typealias MergeSortInput = @Sendable (ChartData) async -> ChartData
    public typealias BubbleSortInput = @Sendable (ChartData) async -> ChartData
    
    public let mergeSort: MergeSortInput
    public let bubbleSort: BubbleSortInput
}
