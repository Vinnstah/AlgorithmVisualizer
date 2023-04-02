import SwiftUI
import Foundation
import ComposableArchitecture

public extension Pathfinding {
    struct View: SwiftUI.View {
        public let store: StoreOf<Pathfinding>
        
        public init(
            store: StoreOf<Pathfinding>
        ) {
            self.store = store
        }
        
        public var body: some SwiftUI.View {
            WithViewStore(self.store, observe: {$0}) { viewStore in
                
                Text("Pathfinding")
                    .onAppear {
                        viewStore.send(.onAppear)
                        fatalError("Fix GRID")
                    }
            }
        }
    }
}

