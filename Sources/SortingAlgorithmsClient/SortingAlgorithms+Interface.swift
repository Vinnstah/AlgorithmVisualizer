import Foundation
import ChartModel

public struct SortingAlgorithms {
    public typealias MergeSortInput = @Sendable ([ChartData.Elements]) async -> [ChartData.Elements]
    
    public let mergeSort: MergeSortInput
}
