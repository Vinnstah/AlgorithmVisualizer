import SwiftUI
import Foundation
import ComposableArchitecture

public extension Sorting {
    struct View: SwiftUI.View {
        
        public let store: StoreOf<Sorting>
        
        public init(
            store: StoreOf<Sorting>
        ) {
            self.store = store
        }
        
        public var body: some SwiftUI.View {
            Text("Sort")
        }
    }
}
