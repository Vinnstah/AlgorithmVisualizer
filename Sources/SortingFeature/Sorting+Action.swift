import ComposableArchitecture
import Foundation

public extension Sorting {
    enum Action: Equatable, Sendable {
        case onAppear
        case arraySizeStepperTapped(Double)
    }
}
