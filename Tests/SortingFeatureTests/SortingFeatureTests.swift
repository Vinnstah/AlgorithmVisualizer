import ComposableArchitecture
@testable import SortingFeature
import UnsortedElements
import XCTest

@MainActor
final class SortingFeatureTests: XCTestCase {
    func test__GIVEN__initialState__WHEN__onAppear__THEN__generate_elements_gets_called() async {
        let uuid = UUID()
        let dummy = UnsortedElements.dummy(id: uuid)
        let numberOfElementsToGenerate = ActorIsolated<UInt?>(nil)
        let store = TestStore(
            initialState: Sorting.State(),
            reducer: Sorting()
        ) {
            $0.uuid = .constant(uuid)
            $0.elementGenerator.generate = {
                await numberOfElementsToGenerate.setValue($0)
                return dummy
            }
        }
        await store.send(.internal(.onAppear))
        
        await store.receive(.internal(.generateElementsResult(.success(dummy)))) {
            $0.array = dummy
        }
        
        await numberOfElementsToGenerate.withValue {
            XCTAssertEqual($0, Sorting.State.defaultElementCount)
        }
    }
    
    func test__GIVEN__unsorted_array__WHEN__mergeSort_is_tapped__THEN__mergeSort_result_is_received() async {
        let uuid = UUID()
        let dummySorted = UnsortedElements.dummySorted(id: uuid)
        
        let store = TestStore(
            initialState: Sorting.State(array: UnsortedElements.dummyUnsorted(id: uuid)),
            reducer: Sorting()
        ) {
            $0.uuid = .incrementing
            $0.sortingAlgorithms.mergeSort = {
                $0
                return dummySorted
            }
        }
        
        store.exhaustivity = .off
        
        await store.send(.internal(.mergeSortTapped))
        await store.send(.internal(.mergeSortResult(.success(.dummySorted(id: uuid)))))
        
        XCTAssertNoDifference(store.state.array, UnsortedElements.dummySorted(id: uuid))
        XCTAssertTrue(store.state.array.isSorted(order: .increasing))
    }
    
    func test__GIVEN__sorted_array__WHEN__mergeSort_returns_a_result__THEN__measure_the_computation_time_of_the_algorithm() async {
        
        let uuid = UUID()
        let dummySorted = UnsortedElements.dummySorted(id: uuid)
        let dummyResult: ContinuousClock.Instant.Duration = .milliseconds(200)
        
        let store = TestStore(
            initialState: Sorting.State(array: UnsortedElements.dummySorted(id: uuid), timer: .zero),
            reducer: Sorting()
        )
        
        store.exhaustivity = .off
        
        await store.send(.internal(.sortingTimer(dummyResult, .merge)))
        
        await store.send(.internal(.mergeSortResult(.success(dummySorted))))
        
        XCTAssertNoDifference(dummyResult, store.state.timer)
        XCTAssertNoDifference(dummySorted, store.state.array)
    }
    
    func test__GIVEN__sorted_array__WHEN__mergeSort_tapped__THEN__return_a_popover_error() async {
        let uuid = UUID()
       let dummySorted = UnsortedElements.dummySorted(id: uuid)
        
        let store = TestStore(
            initialState: Sorting.State(array: UnsortedElements.dummySorted(id: uuid)),
            reducer: Sorting()
        )
        
        await store.send(.internal(.mergeSortTapped))
        await store.receive(.internal(.toggleErrorPopover)) {
            $0.errorPopoverIsShowing = true
        }
        
        XCTAssertTrue(store.state.errorPopoverIsShowing)
    }
    
    func test__GIVEN__sorted_array__WHEN__mergeSort_returns_a_result__THEN__add_the_computation_time_to_state() async {
        
        let uuid = UUID()
        let dummyResult: ContinuousClock.Instant.Duration = .milliseconds(200)
        
        let store = TestStore(
            initialState: Sorting.State(array: UnsortedElements.dummySorted(id: uuid), timer: .zero),
            reducer: Sorting()
        )
        
        await store.send(.internal(.sortingTimer(dummyResult, .merge))) {
            $0.timer = dummyResult
            $0.historicalSortingTimes.addTime(time: dummyResult, type: .merge)
        }
        
        XCTAssertNoDifference(store.state.timer, store.state.historicalSortingTimes.times.measurement.values.first!)
    }
    
    func test__GIVEN__array_of_size_20__WHEN__array_size_stepper_is_tapped__THEN__change_number_of_elements_in_array() async {
        let id = UUID()
        let dummy = UnsortedElements.fiveDummyElements(id: id)
        let numberOfElementsToGenerate = ActorIsolated<UInt?>(5)
        let store = TestStore(
            initialState: Sorting.State(array: .dummyUnsorted(id: id)),
            reducer: Sorting()
        ) {
                $0.elementGenerator.generate = {
                    await numberOfElementsToGenerate.setValue($0)
                    return dummy
            }
            
        }
        await store.send(.internal(.arraySizeStepperTapped(numberOfElementsToGenerate.value!)))
        
        await store.receive(.internal(.generateElementsResult(.success(dummy)))) {
            $0.array = dummy
        }
         
        XCTAssertNoDifference(store.state.array.values, dummy.values)
        XCTAssertNoDifference(store.state.array.values.count, 5)
        
    }
    
    func test__GIVEN__sorted_array__WHEN__rest_array_is_tapped__THEN__rest_array() async {
        let uuid = UUID()
        let numberOfElementsToGenerate = ActorIsolated<UInt?>(nil)
        let errorPopoverIsShowing = ActorIsolated<Bool>(true)
        let dummy = UnsortedElements.dummy(id: uuid)
        let store = TestStore(
            initialState: Sorting.State(array: UnsortedElements.dummySorted(id: uuid)),
            reducer: Sorting()
        ) {
            $0.elementGenerator.generate = {
                await numberOfElementsToGenerate.setValue($0)
                return dummy
            }
        }
        
        await store.send(.internal(.resetArrayTapped))
        
        await store.receive(.internal(.generateElementsResult(.success(dummy)))) {
            $0.array = dummy
        }
    }
}

extension UnsortedElements {
    static func dummy(id: UUID) -> Self {
        return .init(id: id, values: [.init(value: 1, id: id)])
    }
    static func fiveDummyElements(id: UUID) -> Self {
        return .init(id: id, values: [
            .init(value: 1, id: UUID(uuidString: "00000000-0000-0000-0000-000000000000")!),
            .init(value: 4, id: UUID(uuidString: "00000000-0000-0000-0000-000000000001")!),
            .init(value: 5, id: UUID(uuidString: "00000000-0000-0000-0000-000000000002")!),
            .init(value: 12, id: UUID(uuidString: "00000000-0000-0000-0000-000000000003")!),
            .init(value: 62, id: UUID(uuidString: "00000000-0000-0000-0000-000000000004")!)
                                     ])
    }
}

extension UnsortedElements {
    static func dummyUnsorted(id: UUID) -> Self {
        return .init(id: id, values: [
            .init(value: 12, id: UUID(uuidString: "00000000-0000-0000-0000-000000000000")!),
            .init(value: 15, id: UUID(uuidString: "00000000-0000-0000-0000-000000000001")!),
            .init(value: 1, id: UUID(uuidString: "00000000-0000-0000-0000-000000000002")!),
            .init(value: 4, id: UUID(uuidString: "00000000-0000-0000-0000-000000000003")!),
            .init(value: 6, id: UUID(uuidString: "00000000-0000-0000-0000-000000000004")!),
            .init(value: 3, id: UUID(uuidString: "00000000-0000-0000-0000-000000000005")!),
            
        ])
    }
    
    static func dummySorted(id: UUID) -> Self {
        return .init(id: id, values: [
            .init(value: 1, id: UUID(uuidString: "00000000-0000-0000-0000-000000000002")!),
            .init(value: 3, id: UUID(uuidString: "00000000-0000-0000-0000-000000000005")!),
            .init(value: 4, id: UUID(uuidString: "00000000-0000-0000-0000-000000000003")!),
            .init(value: 6, id: UUID(uuidString: "00000000-0000-0000-0000-000000000004")!),
            .init(value: 12, id: UUID(uuidString: "00000000-0000-0000-0000-000000000000")!),
            .init(value: 15, id: UUID(uuidString: "00000000-0000-0000-0000-000000000001")!),
            
        ])
    }
}
