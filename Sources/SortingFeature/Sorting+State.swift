import Foundation
import Charts
import ComposableArchitecture
import ChartModel
import SortingAlgorithmsClient

public struct Sorting: Reducer {
    public init() {}
    
    @Dependency(\.sortingAlgorithms) var sortingAlgorithms
}

public extension Sorting {
    struct State: Equatable, Sendable {
        public var array: ChartData
        
        public init(
            array: ChartData = .init(count: 20, values: [])
        ) {
            self.array = array
        }
        
    }
}

