import Foundation

public struct SortingAlgorithms {
    public typealias MergeSortInput = @Sendable ([Int]) async -> [Int]
    
    public let mergeSort: MergeSortInput
}
