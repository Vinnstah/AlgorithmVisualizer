import ComposableArchitecture
import SortingAlgorithmsClient
import Foundation
import UnsortedElements

public extension Sorting {
    enum Action: Equatable, Sendable {
        case `internal`(InternalAction)
        case view(ViewAction)
        
        public enum ViewAction: Equatable, Sendable {
            case arraySizeStepperTapped(UInt)
            case animationDelayStepperTapped(Double)
            case resetArrayTapped
        }
        
        public enum InternalAction: Equatable, Sendable {
            case mergeSortTapped
            case bubbleSortTapped
            case selectionSortTapped
            case insertionSortTapped
            case onAppear
            case sortingTimer(ContinuousClock.Instant.Duration, SortingTimes.SortingTypes)
            case toggleErrorPopover
            case generateElementsResult(TaskResult<UnsortedElements>)
            case bubbleSortValueResponse([UnsortedElements.Element])
            case selectionSortValueResponse([UnsortedElements.Element])
            case mergeSortValueResponse([UnsortedElements.Element])
            case insertionSortValueResponse([UnsortedElements.Element])
        }
    }
}
