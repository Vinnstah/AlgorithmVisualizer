import SwiftUI
import Foundation
import ComposableArchitecture
import Charts

public extension Sorting {
    struct View: SwiftUI.View {
        
        public let store: StoreOf<Sorting>
        
        public init(
            store: StoreOf<Sorting>
        ) {
            self.store = store
        }
        
        public var body: some SwiftUI.View {
            WithViewStore(self.store, observe: { $0 }) { viewStore in
                GeometryReader { geo in
                    VStack {
                        arraySizeSlider(
                            arraySize: viewStore.binding(
                                get: { $0.arraySize },
                                send: { .arraySizeStepperTapped($0) }
                            )
                        )
                        HStack {
                            Text("Insertion Sort")
                            Text("Selection Sort")
                            Text("Bubble Sort")
                            Text("Merge Sort")
                            Text("Quick Sort")
                            
                        }
                        Charts(data: viewStore.state.array.values)
                            .frame(width: geo.size.width/2, height: geo.size.height/2, alignment: .center)
                    }
                    .onAppear {
                        viewStore.send(.onAppear)
                    }
                    .onChange(of: viewStore.state.arraySize) { _ in
                        viewStore.send(.onAppear)
                    }
                }
            }
        }
    }
}

public extension Sorting.View {
    struct Charts: SwiftUI.View {
        public let data: [ChartData.Elements]
        
        public var body: some SwiftUI.View {
            //            Chart {
            //                ForEach(data) { data in
            //                    BarMark(
            //                        x: .value(Text("\(data.value)"), data.value.description),
            //                        y: .value("", data.value)
            //                    )
            //
            //                }
            //            }
            Chart(data) {
                let values = $0.value
                //                ForEach(data) { data in
                BarMark(x: .value(Text("\($0.value)"), $0.value),
                        y: .value("Value", $0.value))
                //                    BarMark(
                //                        x: .value(Text("\(data.value)"), data.value.description),
                //                        y: .value("", data.value)
                //                    )
                
                //                }
            }
            
            
            //                .chartLegend(.automatic)
        }
    }
}

public extension Sorting.View {
    func arraySizeSlider(arraySize: Binding<Double>) -> some SwiftUI.View {
        VStack {
            Text("\(arraySize.wrappedValue)")
            //            Stepper("Test", value: arraySize)
            Slider(value: arraySize, in: 0...100, step: 1.0)
        }
    }
}
