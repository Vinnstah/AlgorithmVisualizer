import ComposableArchitecture
import Foundation
import SwiftUI
import SortingFeature

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
                TabView(selection: viewStore.binding(send: App.Action.selectedTabChanged)) {
                    VStack {
                        Text("Algorithm Visualizer")
                        
                        List {
                            Section {
                                Text("Sorting Algorithms")
                                Text("Pathfinding Algorithms")
                                Text("Search Algorithms")
                            }
                        }
                    }
                    
                    Sorting.View(
                        store: self.store.scope(
                            state: \.sorting,
                            action: App.Action.sorting
                        )
                    )
                    .tabItem { Text("Sorting") }
                    .tag(Tab.sorting)
                }
            }
        }
    }
}
