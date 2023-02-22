import Charts
import ComposableArchitecture
import Foundation
import SwiftUI
import UnsortedElements

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
                            ArraySizeSlider(
                                value: viewStore.binding(
                                    get: { UInt($0.array.values.count) },
                                    send: { .internal(.arraySizeStepperTapped($0)) }
                                ),
                                resetAction: { viewStore.send(.internal(.resetArrayTapped)) },
                                frameWidth: geo.size.width / 4,
                                binding: viewStore.binding(
                                    get: { $0.errorPopoverIsShowing },
                                    send: .internal(.toggleErrorPopover)
                                )
                            )

                            HStack {
                                Button(action: {
                                    viewStore.send(.internal(.mergeSortTapped), animation: .default)
                                }, label: {
                                    Text("Merge Sort")
                                })

                                Button(action: {
                                    viewStore.send(.internal(.bubbleSortTapped), animation: .default)

                                }, label: {
                                    Text("Bubble Sort")
                                })

                                Text("Insertion Sort")
                                Text("Selection Sort")

                                Text("Quick Sort")
                            }

                            Charts(data: viewStore.state.array.values.elements)
                                .frame(width: geo.size.width * 0.8, height: geo.size.height / 2)

                            VStack {
                                Text("Time to sort the array:")
                                Text("\(viewStore.state.timer.description)")
                            }

                            List {
                                ForEach(viewStore.state.historicalSortingTimes.times.measurement.keys.sorted(), id: \.self) { key in
                                    Section {
                                        HStack {
                                            Text(key)
                                            Text("\(viewStore.state.historicalSortingTimes.times.measurement[key]?.description ?? "")")
                                        }
                                    }
                                }
                            }
                        }
                        Spacer()
                    }
                    .onAppear {
                        viewStore.send(.internal(.onAppear))
                    }
                }
            }
        }
    }
}

public extension Sorting.View {
    struct Charts: SwiftUI.View {
        public let data: [UnsortedElements.Element]

        public var body: some SwiftUI.View {
            Chart {
                ForEach(data, id: \.id) { data in
                    BarMark(
                        x: .value(Text("\(data.value)"), data.value.description),
                        y: .value("", data.value),
                        stacking: .unstacked
                    )
//                    .foregroundStyle(by: .value("isElementCurrentlyBeingSorted", data.sortingStatus))
                }
            }
            .chartForegroundStyleScale([
                "SortingInProgress": .red,
                "Unsorted": Color(.systemBlue),
                "FinishedSorting": .green,
            ])
            .chartLegend(.hidden)
        }
    }
}

public extension Sorting.View {
    struct ArraySizeSlider: SwiftUI.View {
        let value: Binding<UInt>
        let resetAction: () -> Void
        let frameWidth: CGFloat
        let binding: Binding<Bool>
        public var body: some View {
            VStack {
                Text("Array size: \(Int(value.wrappedValue))")
                HStack {
                    Slider(value: .init(get: { Double(value.wrappedValue) }, set: { value.wrappedValue = UInt($0) }), in: 1 ... 100, step: 1.0)
                    Button("Reset") {
                        resetAction()
                    }
                }
            }
            .frame(width: frameWidth)
            .popover(isPresented: binding
            ) {
                Text("The array is already sorted \n Please reset the array")
            }
        }
    }
}

// public let testArray: UnsortedElements = .init(values: [
//    .init(value: 1, sortingStatus: .unsorted),
//    .init(value: 22, sortingStatus: .sortingInProgress),
//    .init(value: 41, sortingStatus: .sortingInProgress),
//    .init(value: 21, sortingStatus: .finishedSorting),
//    .init(value: 14, sortingStatus: .unsorted),
//    .init(value: 82, sortingStatus: .sortingInProgress),
//    .init(value: 42, sortingStatus: .sortingInProgress),
//    .init(value: 21, sortingStatus: .finishedSorting),
//    .init(value: 16, sortingStatus: .unsorted),
//    .init(value: 42, sortingStatus: .sortingInProgress),
//    .init(value: 76, sortingStatus: .unsorted),
//    .init(value: 6, sortingStatus: .finishedSorting),
//
// ])
