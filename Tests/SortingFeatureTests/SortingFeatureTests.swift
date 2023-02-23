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
        //        store.exhaustivity = .off
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
        let clock = TestClock()
        let dummySorted = UnsortedElements.dummySorted(id: uuid)

        let store = TestStore(
            initialState: Sorting.State(array: UnsortedElements.dummyUnsorted(id: uuid)),
            reducer: Sorting()
        ) {
            $0.uuid = .incrementing
            $0.sortingAlgorithms.mergeSort = {
                $0.isSorted(order: .increasing)
                return dummySorted
            }
        }

        store.exhaustivity = .off
        await store.send(.internal(.mergeSortTapped))
        await store.send(.internal(.mergeSortResult(.success(.dummySorted(id: uuid)))))
        await clock.advance(by: .seconds(1))
        XCTAssertNoDifference(store.state.array, UnsortedElements.dummySorted(id: uuid))
        XCTAssertTrue(store.state.array.isSorted(order: .increasing))
    }
    //    func testArraySizeSliderUsed() async {
    //        let store = TestStore(
    //            initialState: Sorting.State.init(),
    //            reducer: Sorting()
    //        )
    //
    //        await store.send(.arraySizeStepperTapped(30)) {
    //            $0.array.values.count = 30
    //        }
    //
    //        XCTAssertEqual(array.values.count, 30)
    //    }
}

extension UnsortedElements {
    static func dummy(id: UUID) -> Self {
        return .init(id: id, values: [.init(value: 1, id: id)])
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
