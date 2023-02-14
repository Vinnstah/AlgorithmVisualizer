import ComposableArchitecture
import Foundation
import SwiftUI

public extension App {
    struct View: SwiftUI.View {
        
        public let store: StoreOf<App>
        
        public init(
            store: StoreOf<App>
        ) {
            self.store = store
        }
        
        public var body: some SwiftUI.View {
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
        }
    }
}
