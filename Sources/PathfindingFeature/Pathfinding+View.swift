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
                LazyVGrid(columns: .init(repeating: GridItem(.fixed(50), spacing: 100, alignment: .center), count: 10)) {
                    ForEach(viewStore.state.grid.grid) { element in
                        ZStack {
                            Rectangle()
                                .foregroundColor(.white)
                                .frame(width: 75, height: 75, alignment: .center)
                            fatalError("FIX SHAPE")
                                .onTapGesture {
                                    print(viewStore.grid.getIndex(id: element.id))
                                }
                            if element.isStartingNode {
                                Image(systemName: "circle")
                            }
                            if element.isEndNode {
                                Image(systemName: "house")
                            }
                        }
                    }
                }
                .onAppear {
                    viewStore.send(.onAppear)
                    print(viewStore.state.grid)
                }
            }
        }
    }
}

