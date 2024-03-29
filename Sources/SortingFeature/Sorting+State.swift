import Charts
import ComposableArchitecture
import ElementGeneratorClient
import Foundation
import SortingAlgorithmsClient
import UnsortedElements

public struct Sorting: Reducer {
    public init() {}

    @Dependency(\.sortingAlgorithms) var sortingAlgorithms
    @Dependency(\.elementGenerator) var elementGenerator
    @Dependency(\.continuousClock) var clock
}

public extension Sorting {
    struct State: Equatable, Sendable {
        public var arrayToSort: UnsortedElements
        public var timer: ContinuousClock.Instant.Duration
        public var errorPopoverIsShowing: Bool
        public var historicalSortingTimes: SortingTimes
        public var sortingAnimationDelay: Double
        public var sortingInProgress: Bool
        public var errorPopoverText: String

        public static let defaultElementCount: UInt = 20

        public init(
            arrayToSort: UnsortedElements = .init(values: []),
            timer: ContinuousClock.Instant.Duration = .zero,
            errorPopoverIsShowing: Bool = false,
            historicalSortingTimes: SortingTimes = .init(),
            sortingAnimationDelay: Double = 10.0,
            sortingInProgress: Bool = false,
            errorPopoverText: String = ""
            
        ) {
            self.arrayToSort = arrayToSort
            self.timer = timer
            self.errorPopoverIsShowing = errorPopoverIsShowing
            self.historicalSortingTimes = historicalSortingTimes
            self.sortingAnimationDelay = sortingAnimationDelay
            self.sortingInProgress = sortingInProgress
            self.errorPopoverText = errorPopoverText
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

    public enum SortingTypes: String, Equatable, Hashable, RawRepresentable, Sendable {
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
        public var measurement: [String: ContinuousClock.Instant.Duration]
        public var id: UUID

        public init(
            measurement: [String: ContinuousClock.Instant.Duration] = [:],
            id: UUID = UUID()
        ) {
            self.measurement = measurement
            self.id = id
        }
    }
}
