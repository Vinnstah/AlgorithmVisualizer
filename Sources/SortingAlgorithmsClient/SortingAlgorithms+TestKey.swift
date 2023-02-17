import Dependencies
import Foundation

#if DEBUG
import XCTestDynamicOverlay

extension SortingAlgorithms {
    
    public static let test = Self(
        mergeSort: XCTUnimplemented("\(Self.self).mergeSort"))
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
