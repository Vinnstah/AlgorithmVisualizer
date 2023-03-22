import ComposableArchitecture
import SortingAlgorithmsClient
import Foundation
import UnsortedElements

public extension Sorting {
    enum Action: Equatable, Sendable {
        case `internal`(InternalAction)
        case view(ViewAction)
        case task

        public enum ViewAction: Equatable, Sendable {
            case arraySizeStepperTapped(UInt)
            case animationDelayStepperTapped(Double)
            case resetArrayTapped
        }
        
        public enum InternalAction: Equatable, Sendable {
            case mergeSortTapped
//            case mergeSortResult(TaskResult<UnsortedElements>)
            case bubbleSortTapped
            case selectionSortTapped
            case onAppear
            case sortingTimer(ContinuousClock.Instant.Duration, SortingTimes.SortingTypes)
            case toggleErrorPopover
            case generateElementsResult(TaskResult<UnsortedElements>)
            case bubbleSortValueResponse([UnsortedElements.Element])
            case selectionSortValueResponse([UnsortedElements.Element])
//            case mergeSortValueResponse([UnsortedElements.Element])
            case mergeSortValueResponse([UnsortedElements.Element])
        }
    }
}
