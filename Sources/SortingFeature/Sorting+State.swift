import Foundation
import Charts
import ComposableArchitecture

public struct Sorting: Reducer {
    public init() {}
}

public extension Sorting {
    struct State: Equatable, Sendable {
        public var array: ChartData
        public var arraySize: Double
        
        public init(
            array: ChartData = .init(values: []),
            arraySize: Double = 20.0
        ) {
            self.array = array
            self.arraySize = arraySize
        }
        
    }
}

public struct ChartData: Identifiable, Equatable, Sendable {
    public var values: [Elements]
    public let id: UUID = UUID()
    
    public init(values: [Elements]) {
        self.values = values
        
        addRandomElementsToArray(count: 20)
    }
    
    public struct Elements: Identifiable, Equatable, Sendable {
        public var value: Int
        public let id: UUID = UUID()
        public let sortingStatus: SortingState
        
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
    
    public mutating func addRandomElementsToArray(count: Double) {
        self.values = []
        for _ in 1...Int(count) {
            self.values.append(
                .init(
                    value: .random(in: 0...100)
                )
            )
        }
    }
    
}
