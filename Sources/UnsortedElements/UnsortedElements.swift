import Algorithms
import Charts
import Dependencies
import Foundation
import IdentifiedCollections

public enum SortingOrder: Sendable, Hashable {
    case increasing
    case decreasing
}

public struct UnsortedElements: Identifiable, Equatable, Sendable {
    public let id: UUID
    public var values: IdentifiedArrayOf<Element>

    public func isSorted(order: SortingOrder) -> Bool {
        return values.isSorted(order: order)
    }

    public init(
        values: IdentifiedArrayOf<Element>
    ) {
        @Dependency(\.uuid) var uuid
        self.init(id: uuid(), values: values)
    }

    public init(
        id: UUID,
        values: IdentifiedArrayOf<Element>
    ) {
        self.id = id
        self.values = values
    }

    public struct Element: Identifiable, Sendable, Comparable {
        public static func < (lhs: Self, rhs: Self) -> Bool {
            return lhs.value < rhs.value
        }

        public var value: Int
        public let id: UUID
        public var previousIndex: Int?
        public var currentIndex: Int

        public init(
            value: Int,
            id: UUID,
            previousIndex: Int? = nil,
            currentIndex: Int
        ) {
            self.value = value
            self.id = id
            self.previousIndex = previousIndex
            self.currentIndex = currentIndex
        }
    }
}

public extension Collection where Element: Comparable {
    func isSorted(order: SortingOrder) -> Bool {
        let compare: (Element, Element) -> Bool = {
            switch order {
            case .decreasing: return { $0 >= $1 }
            case .increasing: return { $0 <= $1 }
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

