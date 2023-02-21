import Charts
import Foundation
import IdentifiedCollections

public struct ChartData: Identifiable, Equatable, Sendable {
    public let id: UUID = UUID()
    public var values: IdentifiedArrayOf<Elements>
    public var sorted: Bool
    
    public init(
        values: IdentifiedArrayOf<Elements>,
        sorted: Bool = false
    ) {
        self.values = values
        self.sorted = sorted
    }
    
    public struct Elements: Identifiable, Equatable, Sendable, Comparable {
        public static func < (lhs: ChartData.Elements, rhs: ChartData.Elements) -> Bool {
            return lhs.value < rhs.value
        }
        
        public var value: Int
        public let id: UUID
        public var sortingStatus: SortingState
        
        public init(
            value: Int,
            id: UUID,
            sortingStatus: SortingState = .unsorted
        ) {
            self.value = value
            self.id = id
            self.sortingStatus = sortingStatus
        }
        
        public enum SortingState: String, Sendable, Plottable {
            case unsorted = "Unsorted"
            case sortingInProgress = "SortingInProgress"
            case finishedSorting = "FinishedSorting"
        }
    }
}
