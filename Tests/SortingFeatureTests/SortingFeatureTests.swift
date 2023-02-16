import XCTest
@testable import SortingFeature
import ComposableArchitecture

@MainActor
final class SortingFeatureTests: XCTestCase {
    func onAppearCreatesRandomArrayWith20Elements() async {
        let store = TestStore(
            initialState: Sorting.State(),
            reducer: Sorting()
        )
        
        await store.send(.onAppear) {
            $0.array.values = []
        }
    }
    
    func arraySizeSliderUsed() async {
        let store = TestStore(
            initialState: Sorting.State.init(),
            reducer: Sorting()
        )
        
        await store.send(.onAppear) {
            $0.array.values = []
        }
    }
}
