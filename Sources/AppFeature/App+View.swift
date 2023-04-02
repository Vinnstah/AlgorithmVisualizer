import ComposableArchitecture
import Foundation
import HomeFeature
import SortingFeature
import SwiftUI
import PathfindingFeature

public extension App {
    struct View: SwiftUI.View {
        public let store: StoreOf<App>

        public init(
            store: StoreOf<App>
        ) {
            self.store = store
        }

        public var body: some SwiftUI.View {
            WithViewStore(self.store, observe: \.selectedTab) { viewStore in
                TabView(
                    selection: viewStore.binding(
                        send: App.Action.selectedTabChanged)
                ) {
                    Home.View(
                        store: self.store.scope(
                            state: \.home,
                            action: App.Action.home
                        )
                    )
                    .tabItem { Text("Home") }
                    .tag(Tab.home)

                    Sorting.View(
                        store: self.store.scope(
                            state: \.sorting,
                            action: App.Action.sorting
                        )
                    )
                    .tabItem {
                        Label("Sorting", systemImage: "chart.bar.xaxis")
                    }
                    .tag(Tab.sorting)
                    
                    Pathfinding.View(
                        store: self.store.scope(
                            state: \.pathfinding,
                            action: App.Action.pathfinding
                        )
                    )
                    .tabItem {
                        Label("Pathfinding", systemImage: "chart.bar.xaxis")
                    }
                    .tag(Tab.pathfinding)
                }
            }
        }
    }
}
