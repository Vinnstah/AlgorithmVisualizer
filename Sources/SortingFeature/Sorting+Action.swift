import ComposableArchitecture
import Foundation
import ChartModel

public extension Sorting {
    enum Action: Equatable, Sendable {
        case `internal`(InternalAction)
        
        public enum InternalAction: Equatable, Sendable {
            case arraySizeStepperTapped(Double)
            case mergeSortTapped
            case mergeSortResult(TaskResult<[ChartData.Elements]>)
            case bubbleSortTapped
            case bubbleSortResult(TaskResult<[ChartData.Elements]>)
            case onAppear
            case sortingTimer(ContinuousClock.Instant.Duration)
        }
    }
}
