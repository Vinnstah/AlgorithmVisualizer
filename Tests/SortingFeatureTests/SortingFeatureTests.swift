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
            $0.arrayToSort = dummy
        }
        
        await numberOfElementsToGenerate.withValue {
            XCTAssertEqual($0, Sorting.State.defaultElementCount)
        }
    }
    
    func test__GIVEN__unsorted_array__WHEN__mergeSort_is_tapped__THEN__mergeSort_result_is_received() async {
        let uuid = UUID()
        let dummySorted = UnsortedElements.dummySorted(id: uuid)
        
        let store = TestStore(
            initialState: Sorting.State(arrayToSort: UnsortedElements.dummyUnsorted(id: uuid)),
            reducer: Sorting()
        ) {
            $0.uuid = .incrementing
            $0.continuousClock = TestClock()
            $0.sortingAlgorithms.mergeSort = { _,_ in }
        }
        
        
        await store.send(.internal(.mergeSortTapped)) {
            $0.sortingInProgress = true
        }
        
        await store.send(.internal(.mergeSortValueResponse(UnsortedElements.dummySorted(id: uuid).values.elements))) {
            $0.arrayToSort = dummySorted
        }
        
        
        
        XCTAssertNoDifference(store.state.arrayToSort, dummySorted)
        XCTAssertTrue(store.state.arrayToSort.isSorted(order: .increasing))
    }
    
    func test__GIVEN__sorted_array__WHEN__mergeSort_returns_a_result__THEN__measure_the_computation_time_of_the_algorithm() async {
        
        let uuid = UUID()
        let dummySorted = UnsortedElements.dummySorted(id: uuid)
        let dummyResult: ContinuousClock.Instant.Duration = .milliseconds(200)
        
        let store = TestStore(
            initialState: Sorting.State(arrayToSort: UnsortedElements.dummySorted(id: uuid), timer: .zero),
            reducer: Sorting()
        ) {
            $0.continuousClock = TestClock()
        }
        
        
        await store.send(.internal(.sortingTimer(dummyResult, .merge))) {
            $0.timer = .milliseconds(200)
            $0.historicalSortingTimes.times.measurement = ["Merge": .milliseconds(200)]
        }
        
        await store.send(.internal(.mergeSortValueResponse(dummySorted.values.elements)))
        
        XCTAssertNoDifference(dummyResult, store.state.timer)
        XCTAssertNoDifference(dummySorted, store.state.arrayToSort)
    }
    
    func test__GIVEN__sorted_array__WHEN__mergeSort_tapped__THEN__return_a_popover_error() async {
        let uuid = UUID()
        
        let store = TestStore(
            initialState: Sorting.State(arrayToSort: UnsortedElements.dummySorted(id: uuid)),
            reducer: Sorting()
        )
        
        await store.send(.internal(.mergeSortTapped))
        await store.receive(.internal(.toggleErrorPopover)) {
            $0.errorPopoverIsShowing = true
            $0.errorPopoverText = "The array is already sorted \n Please reset the array"
        }
        
        XCTAssertTrue(store.state.errorPopoverIsShowing)
    }
    
    func test__GIVEN__sorted_array__WHEN__mergeSort_returns_a_result__THEN__add_the_computation_time_to_state() async {
        
        let uuid = UUID()
        let dummyResult: ContinuousClock.Instant.Duration = .milliseconds(200)
        
        let store = TestStore(
            initialState: Sorting.State(arrayToSort: UnsortedElements.dummySorted(id: uuid), timer: .zero),
            reducer: Sorting()
        )
        
        await store.send(.internal(.sortingTimer(dummyResult, .merge))) {
            $0.timer = dummyResult
            $0.historicalSortingTimes.addTime(time: dummyResult, type: .merge)
        }
        
        XCTAssertNoDifference(store.state.timer, store.state.historicalSortingTimes.times.measurement.values.first!)
    }
    
    func test__GIVEN__unsorted_array__WHEN__quickSort_is_tapped__THEN__quickSort_result_is_received() async {
        let uuid = UUID()
        let dummySorted = UnsortedElements.dummySorted(id: uuid)
        
        let store = TestStore(
            initialState: Sorting.State(arrayToSort: UnsortedElements.dummyUnsorted(id: uuid)),
            reducer: Sorting()
        ) {
            $0.uuid = .incrementing
            $0.continuousClock = TestClock()
            $0.sortingAlgorithms.quickSort = { _,_ in }
        }
        
        
        await store.send(.internal(.quickSortTapped)) {
            $0.sortingInProgress = true
        }
        
        await store.send(.internal(.quickSortValueResponse(UnsortedElements.dummySorted(id: uuid).values.elements))) {
            $0.arrayToSort = dummySorted
        }
        
        
        
        XCTAssertNoDifference(store.state.arrayToSort, dummySorted)
        XCTAssertTrue(store.state.arrayToSort.isSorted(order: .increasing))
    }
    
    func test__GIVEN__sorted_array__WHEN__quickSort_returns_a_result__THEN__measure_the_computation_time_of_the_algorithm() async {
        
        let uuid = UUID()
        let dummySorted = UnsortedElements.dummySorted(id: uuid)
        let dummyResult: ContinuousClock.Instant.Duration = .milliseconds(200)
        
        let store = TestStore(
            initialState: Sorting.State(arrayToSort: UnsortedElements.dummySorted(id: uuid), timer: .zero),
            reducer: Sorting()
        ) {
            $0.continuousClock = TestClock()
        }
        
        
        await store.send(.internal(.sortingTimer(dummyResult, .merge))) {
            $0.timer = .milliseconds(200)
            $0.historicalSortingTimes.times.measurement = ["Merge": .milliseconds(200)]
        }
        
        await store.send(.internal(.quickSortValueResponse(dummySorted.values.elements)))
        
        XCTAssertNoDifference(dummyResult, store.state.timer)
        XCTAssertNoDifference(dummySorted, store.state.arrayToSort)
    }
    
    func test__GIVEN__array_of_size_20__WHEN__array_size_stepper_is_tapped__THEN__change_number_of_elements_in_array() async {
        let id = UUID()
        let dummy = UnsortedElements.fiveDummyElements(id: id)
        let numberOfElementsToGenerate = ActorIsolated<UInt?>(5)
        let store = TestStore(
            initialState: Sorting.State(arrayToSort: .dummyUnsorted(id: id)),
            reducer: Sorting()
        ) {
            $0.elementGenerator.generate = {
                await numberOfElementsToGenerate.setValue($0)
                return dummy
            }
            
        }
        await store.send(.view(.arraySizeStepperTapped(numberOfElementsToGenerate.value!)))
        
        await store.receive(.internal(.generateElementsResult(.success(dummy)))) {
            $0.arrayToSort = dummy
        }
        
        XCTAssertNoDifference(store.state.arrayToSort.values, dummy.values)
        XCTAssertNoDifference(store.state.arrayToSort.values.count, 5)
        
    }
    
    func test__GIVEN__sorted_array__WHEN__reset_array_is_tapped__THEN__reset_array() async {
        let uuid = UUID()
        let numberOfElementsToGenerate = ActorIsolated<UInt?>(nil)
        let errorPopoverIsShowing = ActorIsolated<Bool>(true)
        let dummy = UnsortedElements.dummy(id: uuid)
        let store = TestStore(
            initialState: Sorting.State(arrayToSort: UnsortedElements.dummySorted(id: uuid)),
            reducer: Sorting()
        ) {
            $0.elementGenerator.generate = {
                await numberOfElementsToGenerate.setValue($0)
                return dummy
            }
        }
        
        await store.send(.view(.resetArrayTapped))
        
        await store.receive(.internal(.generateElementsResult(.success(dummy)))) {
            $0.arrayToSort = dummy
        }
    }
    
        func test__GIVEN__sorted_array__WHEN__reset_array_is_tapped_and_array_slider_is_adjusted_and_mergeSort_tapped__THEN__sort_the_array() async {
            let uuid = UUID()
            let numberOfElementsToGenerate = ActorIsolated<UInt?>(nil)
            let errorPopoverIsShowing = ActorIsolated<Bool>(true)
            let dummy = UnsortedElements.dummy(id: uuid)
            let store = TestStore(
                initialState: Sorting.State(arrayToSort: UnsortedElements.dummySorted(id: uuid)),
                reducer: Sorting()
            ) {
                $0.elementGenerator.generate = {
                    await numberOfElementsToGenerate.setValue($0)
                    return dummy
                }
                $0.sortingAlgorithms.mergeSort = { _, _ in }
            }
            
            await store.send(.view(.resetArrayTapped))
            await store.receive(.internal(.generateElementsResult(.success(dummy)))) {
                $0.arrayToSort = dummy
            }
            await store.send(.view(.arraySizeStepperTapped(40)))
            await store.receive(.internal(.generateElementsResult(.success(dummy))))
            
            await numberOfElementsToGenerate.withValue {
                XCTAssertEqual($0, 40)
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
