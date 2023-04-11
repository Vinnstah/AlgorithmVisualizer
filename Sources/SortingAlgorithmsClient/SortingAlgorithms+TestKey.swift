import Dependencies
import Foundation

#if DEBUG
    import XCTestDynamicOverlay

    public extension SortingAlgorithms {
        static let test = Self(
            mergeSort: { _,_  in },
            bubbleSort: { _,_  in },
            selectionSort: { _,_  in },
            insertionSort: { _,_  in },
            quickSort: { _,_  in }
        )
    }

    extension SortingAlgorithms: TestDependencyKey {
        public static let testValue = SortingAlgorithms.test
    }
#endif

public extension DependencyValues {
    var sortingAlgorithms: SortingAlgorithms {
        get { self[SortingAlgorithms.self] }
        set { self[SortingAlgorithms.self] = newValue }
    }
}
