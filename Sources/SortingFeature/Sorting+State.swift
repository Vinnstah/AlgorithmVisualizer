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
    @Dependency(\.continuousClock) var clock
}

public extension Sorting {
    struct State: Equatable, Sendable {
        public var array: ChartData
        public var timer: ContinuousClock.Instant.Duration
        public var errorPopoverIsShowing: Bool
        public var historicalSortingTimes: SortingTimes
        
        public init(
            array: ChartData = .init(values: []),
            timer: ContinuousClock.Instant.Duration = .zero,
            errorPopoverIsShowing: Bool = false,
            historicalSortingTimes: SortingTimes = .init()
        ) {
            self.array = array
            self.timer = timer
            self.errorPopoverIsShowing = errorPopoverIsShowing
            self.historicalSortingTimes = historicalSortingTimes
        }
    }
}

extension ContinuousClock: Equatable {
    public static func == (lhs: ContinuousClock, rhs: ContinuousClock) -> Bool {
        lhs.now == rhs.now
    }
}

extension TextState: @unchecked Sendable {}

public struct SortingTimes: Equatable, Hashable, Sendable {
    
    public var times: SortingTimeContainer
    
    public init(
        times: SortingTimeContainer = .init(measurement: [:])
    ) {
        self.times = times
        
    }
    
    public mutating func addTime(time: ContinuousClock.Instant.Duration, type: SortingTypes) {
        switch type {
        case .bubble:
            times.measurement[SortingTypes.bubble.rawValue] = time
        case .merge:
            times.measurement[SortingTypes.merge.rawValue] = time
        case .insertion:
            times.measurement[SortingTypes.insertion.rawValue] = time
        case .selection:
            times.measurement[SortingTypes.selection.rawValue] = time
        case .quick:
            times.measurement[SortingTypes.quick.rawValue] = time
        }
    }
    public enum SortingTypes: String, Equatable, Hashable, RawRepresentable {
        case bubble
        case merge
        case insertion
        case selection
        case quick
        
        public var rawValue: String {
            switch self {
            case .bubble:
                return "Bubble"
            case .merge:
                return "Merge"
            case .insertion:
                return "Insertion"
            case .selection:
                return "Selection"
            case .quick:
                return "Quick"
            }
        }
    }
    
    public struct SortingTimeContainer: Equatable, Hashable, Identifiable, Sendable {
        public var measurement: [String : ContinuousClock.Instant.Duration]
        public var id: UUID
        
        public init(
            measurement: [String : ContinuousClock.Instant.Duration] = [:],
            id: UUID = UUID()) {
                self.measurement = measurement
                self.id = id
            }
    }
}
