import ComposableArchitecture

// MARK: - Home

public struct Home: Sendable, ReducerProtocol {
    public init() {}
}

public extension Home {
    func reduce(into _: inout State, action _: Action) -> EffectTask<Action> {
        .none
    }
}
