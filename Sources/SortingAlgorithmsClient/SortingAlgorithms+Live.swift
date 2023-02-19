import ComposableArchitecture
import Foundation
import ChartModel

extension SortingAlgorithms: DependencyKey {
    static public var liveValue: SortingAlgorithms = Self(
        mergeSort: { array in
            return await merge(array)
        }, bubbleSort:  { array in
            return await bubble(array: array)
            
        }
        )
}


