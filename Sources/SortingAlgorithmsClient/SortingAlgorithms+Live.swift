import ComposableArchitecture
import Foundation
import UnsortedElements

extension SortingAlgorithms: DependencyKey {
    public static var liveValue: SortingAlgorithms = Self(
        mergeSort: { array in
            await merge(array)
        },
        bubbleSort: { array in
            await bubble(array: array)
        }
    )
}
