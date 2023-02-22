import ComposableArchitecture
@testable import SortingFeature
import XCTest

@MainActor
final class SortingFeatureTests: XCTestCase {
    func test__GIVEN__initialState__WHEN__onAppear__THEN__generate_elements_gets_called() async {}

//        let numberOfElementsToGenerate = ActorIsolated<Int?>(nil)
//        let store = TestStore(
//            initialState: Sorting.State(),
//            reducer: Sorting()
//        ) {
//            $0.uuid = .incrementing
//            $0.elementGenerator.generateElements = {
//                await numberOfElementsToGenerate.setValue($0)
//            }
//        }
//
//        await store.send(.internal(.onAppear)) {
//            $0.array.values = .init(arrayLiteral: .init(value: 1, id: store.dependencies.uuid.callAsFunction()))
//        }

//        {
//            $0.array.values = IdentifiedArrayOf(repeating: .init(value: 1, id: store.dependencies.uuid.callAsFunction()), count: 20)
//        }
//        XCTAssertEqual(store.state.array.values.count, 20)
//    }

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
