import ComposableArchitecture

// MARK: - Home.View

public extension Home {
    @MainActor
    struct View: SwiftUI.View {
        private let store: StoreOf<Home>

        public init(store: StoreOf<Home>) {
            self.store = store
        }
    }
}

public extension Home.View {
    var body: some View {
        WithViewStore(
            store,
            observe: ViewState.init(state:),
            send: { .view($0) }
        ) { viewStore in
            // TODO: implement
            Text("Implement: Home")
                .background(Color.yellow)
                .foregroundColor(.red)
                .onAppear { viewStore.send(.appeared) }
        }
    }
}

// MARK: - Home.View.ViewState

extension Home.View {
    struct ViewState: Equatable {
        init(state _: Home.State) {
            // TODO: implement
        }
    }
}

#if DEBUG
    import SwiftUI // NB: necessary for previews to appear

    // MARK: - Home_Preview

    struct Home_Preview: PreviewProvider {
        static var previews: some View {
            Home.View(
                store: .init(
                    initialState: .previewValue,
                    reducer: Home()
                )
            )
        }
    }
#endif
