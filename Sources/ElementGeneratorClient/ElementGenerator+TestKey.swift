import Dependencies
import Foundation

#if DEBUG
import XCTestDynamicOverlay

extension ElementGenerator {
    public static let test = Self(
        generateElements: XCTUnimplemented("\(Self.self).elementGenerator")
    )
}

extension ElementGenerator: TestDependencyKey {
    public static let testValue = ElementGenerator.test
}
#endif

public extension DependencyValues {
    var elementGenerator: ElementGenerator {
        get { self[ElementGenerator.self] }
        set { self[ElementGenerator.self] = newValue }
    }
}
