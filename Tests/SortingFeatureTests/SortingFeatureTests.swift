import XCTest
@testable import SortingFeature
import ComposableArchitecture

@MainActor
final class SortingFeatureTests: XCTestCase {
    func testCreating20RandomElementsOnAppear() async {
        let store = TestStore(
            initialState: Sorting.State(),
            reducer: Sorting()
        )
        store.dependencies.uuid = .incrementing
        store.dependencies.elementGenerator = .testValue
        
        await store.send(.internal(.onAppear)) {
            $0.array.values = .init(arrayLiteral: .init(value: 1, id: store.dependencies.uuid.callAsFunction()))
        }
//        {
//            $0.array.values = IdentifiedArrayOf(repeating: .init(value: 1, id: store.dependencies.uuid.callAsFunction()), count: 20)
//        }
        XCTAssertEqual(store.state.array.values.count, 20)
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
