import ComposableArchitecture
import SwiftUI
import AppFeature

@main
struct AlgorithmVisualizerApp: SwiftUI.App {
    var body: some Scene {
        WindowGroup {
            App.View(
                store: .init(
                    initialState: .init(),
                    reducer: App()._printChanges()
                )
            )
        }
    }
}
