import ComposableArchitecture
import Foundation
import UnsortedElements

public extension Sorting {
    enum Action: Equatable, Sendable {
        case `internal`(InternalAction)
        case task

        public enum InternalAction: Equatable, Sendable {
            case arraySizeStepperTapped(UInt)
            case mergeSortTapped
            case mergeSortResult(TaskResult<UnsortedElements>)
            case bubbleSortTapped
            case bubbleSortResult(TaskResult<UnsortedElements>)
            case onAppear
            case sortingTimer(ContinuousClock.Instant.Duration, SortingTimes.SortingTypes)
            case toggleErrorPopover
            case resetArrayTapped
            case generateElementsResult(TaskResult<UnsortedElements>)
            case bubbleSortValueResponse([Foo])
        }
    }
}
