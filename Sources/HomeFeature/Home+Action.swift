
// MARK: - Home.Action
public extension Home {
	enum Action: Sendable, Equatable {
		case `internal`(InternalAction)
		case delegate(DelegateAction)
	}
}

public extension Home.Action {
	static func view(_ action: ViewAction) -> Self { .internal(.view(action)) }
}

// MARK: - Home.Action.ViewAction
public extension Home.Action {
	enum ViewAction: Sendable, Equatable {
		case appeared
	}
}

// MARK: - Home.Action.InternalAction
public extension Home.Action {
	enum InternalAction: Sendable, Equatable {
		case view(ViewAction)
		case system(SystemAction)
	}
}

// MARK: - Home.Action.SystemAction
public extension Home.Action {
	enum SystemAction: Sendable, Equatable {}
}

// MARK: - Home.Action.DelegateAction
public extension Home.Action {
	enum DelegateAction: Sendable, Equatable {}
}
