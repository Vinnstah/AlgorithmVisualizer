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
                    HStack(alignment: .center) {
                        Spacer()
                        VStack(alignment: .center) {
                            arraySizeSlider(
                                arraySize: viewStore.binding(
                                    get: { $0.arraySize },
                                    send: { .arraySizeStepperTapped($0) }
                                )
                            )
                            .frame(width: geo.size.width/4)
                            
                            HStack {
                                Text("Insertion Sort")
                                Text("Selection Sort")
                                Text("Bubble Sort")
                                Text("Merge Sort")
                                Text("Quick Sort")
                                
                            }
                            Charts(data: viewStore.state.array.values)
                                .frame(width: geo.size.width * 0.8, height: geo.size.height/2)
                        }
                        Spacer()
                    }
                        .onAppear {
                            viewStore.send(.onAppear)
                        }
                        .onChange(of: viewStore.state.arraySize) { _ in
                            viewStore.send(.internal(.arraySizeChanged))
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
            Chart {
                ForEach(data, id: \.id) { data in
                    BarMark(
                        x: .value(Text("\(data.value)"), data.value.description),
                        y: .value("", data.value),
                        stacking: .unstacked
                    )
                    .foregroundStyle(by: .value("isElementCurrentlyBeingSorted", data.sortingStatus))
                }
            }
            .chartForegroundStyleScale([
                "SortingInProgress" : .red,
                "Unsorted": Color(.systemBlue),
                "FinishedSorting": .green
            ])
            .chartLegend(.hidden)
        }
    }
}

public extension Sorting.View {
    func arraySizeSlider(arraySize: Binding<Double>) -> some SwiftUI.View {
        VStack {
            Text("\(Int(arraySize.wrappedValue))")
            Slider(value: arraySize, in: 1...100, step: 1.0)
        }
    }
}

public let testArray: ChartData = .init(values: [
    .init(value: 1, sortingStatus: .unsorted),
    .init(value: 22, sortingStatus: .sortingInProgress),
    .init(value: 41, sortingStatus: .sortingInProgress),
    .init(value: 21, sortingStatus: .finishedSorting),
    .init(value: 14, sortingStatus: .unsorted),
    .init(value: 82, sortingStatus: .sortingInProgress),
    .init(value: 42, sortingStatus: .sortingInProgress),
    .init(value: 21, sortingStatus: .finishedSorting),
    .init(value: 16, sortingStatus: .unsorted),
    .init(value: 42, sortingStatus: .sortingInProgress),
    .init(value: 76, sortingStatus: .unsorted),
    .init(value: 6, sortingStatus: .finishedSorting),
    
])
