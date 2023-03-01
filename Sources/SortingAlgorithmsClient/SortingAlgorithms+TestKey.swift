import Dependencies
import Foundation

#if DEBUG
    import XCTestDynamicOverlay

    public extension SortingAlgorithms {
        static let test = Self(
            mergeSort: XCTUnimplemented("\(Self.self).mergeSort"),
            mergeSortOutput: XCTUnimplemented("\(Self.self).mergeSortOutput"),
            bubbleSortOutput: XCTUnimplemented("\(Self.self).bubbleSortOutput"),
            bubbleSortReceiver: XCTUnimplemented("\(Self.self).bubbleSortReceiver")
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
