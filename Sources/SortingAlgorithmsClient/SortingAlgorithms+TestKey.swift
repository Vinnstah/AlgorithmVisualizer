import Dependencies
import Foundation

#if DEBUG
    import XCTestDynamicOverlay

    public extension SortingAlgorithms {
        static let test = Self(
            mergeSort: XCTUnimplemented("\(Self.self).mergeSort"),
            mergeSortReceiver: XCTUnimplemented("\(Self.self).mergeSortReceiver"),
            bubbleSort: XCTUnimplemented("\(Self.self).bubbleSort"),
            bubbleSortReceiver: XCTUnimplemented("\(Self.self).bubbleSortReceiver"),
            selectionSort: unimplemented() 
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
