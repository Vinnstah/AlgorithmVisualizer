import Foundation
import Charts
import ComposableArchitecture
import ChartModel
import SortingAlgorithmsClient
import ElementGeneratorClient

public struct Sorting: Reducer {
    public init() {}
    
    @Dependency(\.sortingAlgorithms) var sortingAlgorithms
    @Dependency(\.elementGenerator) var elementGenerator
    @Dependency(\.uuid) var uuid
    @Dependency(\.continuousClock) var clock
}

public extension Sorting {
    struct State: Equatable, Sendable {
        public var array: ChartData
        public var timer: ContinuousClock.Instant.Duration
        
        public init(
            array: ChartData = .init(values: []),
            timer: ContinuousClock.Instant.Duration = .zero
        ) {
            self.array = array
            self.timer = timer
        }
    }
}

extension ContinuousClock: Equatable {
    public static func == (lhs: ContinuousClock, rhs: ContinuousClock) -> Bool {
        lhs.now == rhs.now
    }
    
    
}
