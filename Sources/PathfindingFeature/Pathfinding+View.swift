import SwiftUI
import Foundation
import ComposableArchitecture

public extension Pathfinding {
    @MainActor
    struct View: SwiftUI.View {
        public let store: StoreOf<Pathfinding>
        
        public init(
            store: StoreOf<Pathfinding>
        ) {
            self.store = store
        }
        
        public var body: some SwiftUI.View {
            WithViewStore(self.store, observe: { $0 }) { viewStore in
                VStack {
                    Button(action: { viewStore.send(.bfs, animation: .default) }, label: { Text("BFS")})
                    LazyVGrid(columns: .init(repeating: GridItem(.fixed(75)), count: 10)) {
                        ForEach(viewStore.state.grid.nodes) { node in
                            ZStack {
                                if viewStore.state.shortestPath.contains(where: { $0 == node}) {
                                    Rectangle()
                                        .foregroundColor(viewStore.state.shortestPath.contains(where: { $0 == node}) ? .green : .white)
                                    .frame(width: 75, height: 75, alignment: .center)
                                } else {
                                    Rectangle()
                                        .foregroundColor(viewStore.state.visitedNodes.contains(where: { $0 == node}) ? .indigo : .white)
                                        .frame(width: 75, height: 75, alignment: .center)
                                }
                                if node.isStartingNode {
                                    Image(systemName: "house")
                                        .foregroundColor(.black)
                                        .font(.system(size: 30))
                                }
                                if node.isEndNode {
                                    Image(systemName: "flag")
                                        .foregroundColor(.black)
                                        .font(.system(size: 30))
                                }
                            }
                        }
                    }
                }
                .onAppear {
                    viewStore.send(.onAppear)
                }
            }
        }
    }
}

