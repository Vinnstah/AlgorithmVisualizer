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
            for index in 1 ... count {
                values.append(
                    UnsortedElements.Element(
                        value: .random(in: 0 ... 100),
                        id: uuid(),
                        currentIndex: Int(index)
                    )
                )
            }
            return .init(values: .init(uniqueElements: values, id: \.id))
        }
    }
}
