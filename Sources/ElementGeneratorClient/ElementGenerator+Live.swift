import ComposableArchitecture
import Dependencies
import Foundation
import UnsortedElements

extension ElementGenerator: DependencyKey {
    
    public static var liveValue: ElementGenerator {
        @Dependency(\.uuid) var uuid
        return Self(
            generate: { count in
                generateRandomElements(count)
            }
        )
        @Sendable func generateRandomElements(_ count: UInt) -> UnsortedElements {
            var values: [UnsortedElements.Element] = []
            for _ in 0 ... count - 1 {
                values.append(
                    UnsortedElements.Element(
                        value: .random(in: 0 ... 100),
                        id: uuid()
                    )
                )
            }
            return .init(values: .init(uniqueElements: values, id: \.id))
        }
    }
}
