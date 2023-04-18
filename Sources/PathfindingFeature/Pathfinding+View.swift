import SwiftUI
import Foundation
import ComposableArchitecture

extension Pathfinding {
    
    @MainActor
    public struct View: SwiftUI.View {
        public let store: StoreOf<Pathfinding>
        
        public init(
            store: StoreOf<Pathfinding>
        ) {
            self.store = store
        }
        
        public var body: some SwiftUI.View {
            WithViewStore(self.store, observe: { $0 }) { viewStore in
                GeometryReader { geo in
                    VStack {
                        HStack {
                            Button(action: { viewStore.send(.view(.bfsTapped), animation: .default) }, label: { Text("BFS")})
                                .disabled(viewStore.state.pathfindingInProgress)
                            
                            Button(action: { viewStore.send(.view(.dfsTapped), animation: .default) }, label: { Text("DFS")})
                                .disabled(viewStore.state.pathfindingInProgress)
                            
                            Button(action: { viewStore.send(.view(.resetGridTapped), animation: .default) }, label: { Text("Reset")})
                        }
                        HStack {
                            animationDelay(animationDelayValue: viewStore.binding(
                                get: { $0.pathfindingAnimationDelay },
                                send: { .pathfindingAnimationDelayTapped($0) }
                            ), pathfindingInProgress: viewStore.state.pathfindingInProgress)
                            .frame(width: geo.size.width/3)
                            
                        }
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
                                    if node.blocked! {
                                        Image(systemName: "square")
                                            .foregroundColor(.black)
                                            .font(.system(size: 30))
                                    }
                                }
                            }
                        }
                    }
                    .onAppear {
                        viewStore.send(.view(.appeared))
                    }
                }
            }
        }
    }
}
extension Pathfinding.View {
    
    public func animationDelay(
        animationDelayValue: Binding<Double>,
        pathfindingInProgress: Bool
    ) -> some SwiftUI.View {
        
        VStack {
            Text("Animation delay ms: \(Int(animationDelayValue.wrappedValue))")
            HStack {
                Slider(
                    value: .init(
                        get: { animationDelayValue.wrappedValue },
                        set: { animationDelayValue.wrappedValue = $0 }
                    ), in: 1 ... 1000, step: 10.0
                )
                .disabled(pathfindingInProgress)
                Spacer()
            }
        }
    }
}
