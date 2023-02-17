import XCTest
@testable import SortingFeature
import ComposableArchitecture

@MainActor
final class SortingFeatureTests: XCTestCase {
    func testOnAppearCreatesRandomArrayWith20Elements() async {
        let store = TestStore(
            initialState: Sorting.State(),
            reducer: Sorting()
        )
        await store.send(.onAppear) 
            
        XCTAssertEqual(store.state.array.values.count, 20)
    }
    
    func testArraySizeSliderUsed() async {
        let store = TestStore(
            initialState: Sorting.State.init(),
            reducer: Sorting()
        )
        
        await store.send(.arraySizeStepperTapped(30)) {
            $0.arraySize = 30
        }
        
        XCTAssertEqual(store.state.arraySize, 30)
    }
}
