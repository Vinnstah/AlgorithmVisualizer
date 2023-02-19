import ComposableArchitecture
import Foundation
import ChartModel
import Dependencies

extension ElementGenerator: DependencyKey {
    public static var liveValue: ElementGenerator {
        @Dependency(\.uuid) var uuid
        return Self(
            generateElements: { count in
                generateRandomElements(repeting: count)
            }
        )
        @Sendable func generateRandomElements(repeting count: Int) -> [ChartData.Elements] {
            var values: [ChartData.Elements] = []
            for _ in 1...count {
                values.append(
                    ChartData.Elements(
                        value: .random(in: 0...100),
                        id: uuid.callAsFunction()
                    )
                )
            }
            return values
        }
    }
    }
    
    
//
//    static public func liveValue() -> ElementGenerator {
//
//        @Dependency(\.uuid) var uuid
//        return Self(
//            elementGenerator: { count, ids in
//                generateRandomElements(repeting: count, id: ids )
//            }
//        )
//        @Sendable func generateRandomElements(repeting count: Int, id: UUID) -> [ChartData.Elements] {
//            var values: [ChartData.Elements] = []
//            for _ in 1...count {
//                values.append(
//                    ChartData.Elements(
//                        value: .random(in: 0...100),
//                        id: uuid.callAsFunction()
//                    )
//                )
//            }
//            return values
//        }
//    }
//}

//public func generateRandomElements(repeting count: Int, id: UUID) -> [ChartData.Elements] {
//    var values: [ChartData.Elements] = []
//    for _ in 1...count {
//        values.append(
//            ChartData.Elements(
//                value: .random(in: 0...100),
//                id: <#UUID#>
//            )
//        )
//    }
//    return values
//}
