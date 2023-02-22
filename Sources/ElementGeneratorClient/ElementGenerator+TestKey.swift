import Dependencies
import Foundation

#if DEBUG
    import XCTestDynamicOverlay

    public extension ElementGenerator {
        static let test = Self(
            generate: XCTUnimplemented("\(Self.self).elementGenerator")
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
