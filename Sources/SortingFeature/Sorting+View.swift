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
                                    get: { UInt($0.arrayToSort.values.count) },
                                    send: { .view(.arraySizeStepperTapped($0)) }
                                ),
                                resetAction: { viewStore.send(.view(.resetArrayTapped)) },
                                frameWidth: geo.size.width / 4,
                                binding: viewStore.binding(
                                    get: { $0.errorPopoverIsShowing },
                                    send: .internal(.toggleErrorPopover)
                                ),
                                animationDelayValue: viewStore.binding(
                                    get: { $0.sortingAnimationDelay },
                                    send: { .view(.animationDelayStepperTapped($0)) }
                                ),
                                errorPopoverText: viewStore.state.errorPopoverText,
                                sortingInprogress: viewStore.state.sortingInProgress
                            )
                            
                            HStack {
                                Button(action: {
                                    viewStore.send(.internal(.mergeSortTapped), animation: .default)
                                }, label: {
                                    Text("Merge Sort")
                                })
                                .disabled(viewStore.state.sortingInProgress)
                                
                                Button(action: {
                                    viewStore.send(.internal(.bubbleSortTapped), animation: .default)
                                    
                                }, label: {
                                    Text("Bubble Sort")
                                })
                                .disabled(viewStore.state.sortingInProgress)
                                
                                
                                Button(action: {
                                    viewStore.send(.internal(.insertionSortTapped), animation: .default)
                                    
                                }, label: {
                                    Text("Insertion Sort")
                                })
                                .disabled(viewStore.state.sortingInProgress)
                                
                                
                                
                                Button(action: {
                                    viewStore.send(.internal(.selectionSortTapped), animation: .default)
                                    
                                }, label: {
                                    Text("Selection Sort")
                                })
                                .disabled(viewStore.state.sortingInProgress)
                                
                                Button(action: {
                                    viewStore.send(.internal(.quickSortTapped), animation: .default)
                                    
                                }, label: {
                                    Text("Quick Sort")
                                })
                                .disabled(viewStore.state.sortingInProgress)
                                
                            }
                            
                            Charts(data: viewStore.state.arrayToSort.values.elements)
                                .frame(width: geo.size.width * 0.8, height: geo.size.height / 2)
                            
                            VStack {
                                Text("Time to sort the array:")
                                Text("\(viewStore.state.timer.description)")
                            }
                            
                            //                            List {
                            //                                ForEach(viewStore.state.historicalSortingTimes.times.measurement.keys.sorted(), id: \.self) { key in
                            //                                    Section {
                            //                                        HStack {
                            //                                            Text(key)
                            //                                            Text("\(viewStore.state.historicalSortingTimes.times.measurement[key]?.description ?? "")")
                            //                                        }
                            //                                    }
                            //                                }
                            //                            }
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
        let animationDelayValue: Binding<Double>
        let errorPopoverText: String
        let sortingInprogress: Bool
        public var body: some View {
            HStack {
                VStack {
                    Text("Animation delay ms: \(Int(animationDelayValue.wrappedValue))")
                    HStack {
                        Slider(
                            value: .init(
                                get: { animationDelayValue.wrappedValue },
                                set: { animationDelayValue.wrappedValue = $0 }
                            ), in: 1 ... 1000, step: 10.0
                        )
                        .disabled(sortingInprogress)
                        Spacer()
                    }
                }
                VStack {
                    Text("Array size: \(Int(value.wrappedValue))")
                    HStack {
                        Slider(
                            value: .init(
                                get: { Double(value.wrappedValue) },
                                set: { value.wrappedValue = UInt($0) }
                            ), in: 1 ... 100, step: 1.0
                        )
                            .disabled(sortingInprogress)
                        Button("Reset") {
                            resetAction()
                        }
                    }
                }
                
                .popover(isPresented: binding
                ) {
                    Text(errorPopoverText)
                }
            }
            .frame(width: frameWidth)
        }
    }
}
