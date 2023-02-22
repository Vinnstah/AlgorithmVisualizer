import Algorithms
import Charts
import Foundation
import IdentifiedCollections

public enum SortingOrder: Sendable, Hashable {
    case increasing
    case decreasing
}

public struct UnsortedElements: Identifiable, Equatable, Sendable {
    public let id: UUID = .init()
    public var values: IdentifiedArrayOf<Element>

    public func isSorted(order: SortingOrder) -> Bool {
        values.isSorted(order: order)
    }

    public init(
        values: IdentifiedArrayOf<Element>
    ) {
        self.values = values
    }

    public struct Element: Identifiable, Sendable, Comparable {
        public static func < (lhs: Self, rhs: Self) -> Bool {
            return lhs.value < rhs.value
        }

        public var value: Int
        public let id: UUID

        public init(
            value: Int,
            id: UUID
        ) {
            self.value = value
            self.id = id
        }
    }
}

public extension Collection where Element: Comparable {
    func isSorted(order: SortingOrder) -> Bool {
        let compare: (Element, Element) -> Bool = {
            switch order {
            case .decreasing: return { $0 > $1 }
            case .increasing: return { $0 < $1 }
            }
        }()
        return windows(ofCount: 2)
            .map { Array($0) }
            .map { ($0.first!, $0.last!) }
            .map(compare)
            .lazy
            .reduce(true) { $0 && $1 }
    }
}
