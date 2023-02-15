import ComposableArchitecture

// MARK: - Home
public struct Home: Sendable, ReducerProtocol {
	public init() {}
}

public extension Home {
	func reduce(into state: inout State, action: Action) -> EffectTask<Action> {
		.none
	}
}
