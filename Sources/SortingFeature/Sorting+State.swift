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
        public var popoverTextState: TextState?
        
        public init(
            array: ChartData = .init(values: []),
            timer: ContinuousClock.Instant.Duration = .zero,
            errorPopoverIsShowing: Bool = false,
            popoverTextState: TextState? = nil
        ) {
            self.array = array
            self.timer = timer
            self.errorPopoverIsShowing = errorPopoverIsShowing
            self.popoverTextState = popoverTextState
        }
    }
}

extension ContinuousClock: Equatable {
    public static func == (lhs: ContinuousClock, rhs: ContinuousClock) -> Bool {
        lhs.now == rhs.now
    }
}

extension TextState: @unchecked Sendable {}
