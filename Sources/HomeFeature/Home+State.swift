
// MARK: - Home.State

public extension Home {
    struct State: Sendable, Equatable {
        public init() {}
    }
}

#if DEBUG
    public extension Home.State {
        static let previewValue: Self = .init()
    }
#endif
