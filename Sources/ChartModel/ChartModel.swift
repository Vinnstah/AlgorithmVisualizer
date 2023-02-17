import Charts
import Foundation

public struct ChartData: Identifiable, Equatable, Sendable {
    public let id: UUID = UUID()
    public var count: Double {
        didSet {
           values = addRandomElementsToArray()
        }
    }
    public var values: [Elements]
    
    public init(
        count: Double,
        values: [Elements]
    ) {
        self.count = count
        self.values = values
    }
    
    public struct Elements: Identifiable, Equatable, Sendable, Comparable {
        public static func < (lhs: ChartData.Elements, rhs: ChartData.Elements) -> Bool {
            return lhs.value < rhs.value
        }
        
        public var value: Int
        public let id: UUID = UUID()
        public var sortingStatus: SortingState
        
        public init(
            value: Int,
            sortingStatus: SortingState = .unsorted
        ) {
            self.value = value
            self.sortingStatus = sortingStatus
        }
        
        public enum SortingState: String, Sendable, Plottable {
            case unsorted = "Unsorted"
            case sortingInProgress = "SortingInProgress"
            case finishedSorting = "FinishedSorting"
        }
    }
    
    public func addRandomElementsToArray() -> [Elements] {
        var values: [Elements] = []
        for _ in 1...Int(self.count) {
            values.append(
                .init(
                    value: .random(in: 0...100)
                )
            )
        }
        return values
    }
    
//    public func addRandomElementsToArray(count: Double) -> [Elements] {
//        var values: [Elements] = []
//        for _ in 1...Int(count) {
//            values.append(
//                .init(
//                    value: .random(in: 0...100)
//                )
//            )
//        }
//        return values
//    }
}
