import ComposableArchitecture
import Foundation
import UnsortedElements
import AsyncExtensions

extension SortingAlgorithms: DependencyKey {
    public static var liveValue: SortingAlgorithms {
        return Self(
            mergeSort: { arrayToSort, callback in
                var sortingList: [UnsortedElements] = []
                _merge(array: arrayToSort) { elementsToSort in
                    sortingList.append(elementsToSort)
//                    await algorithmHolder.emit(elementsToSort)
                }
                sortingList.append(.init(values: .init()))
                callback(sortingList)
            },
            bubbleSort: { arrayToSort, callback in
                var sortingList: [UnsortedElements] = []
                _bubbleSort(arrayToSort) { swappedPairs in
                    sortingList.append(swappedPairs)
                }
                sortingList.append(.init(values: .init()))
                callback(sortingList)
            },
            selectionSort: { array, callback in
                var arrayToSort = array
                var sortingList: [UnsortedElements] = []
                 _selectionSort(&arrayToSort, 0) { elementsToSort in
                     sortingList.append(elementsToSort)
                }
                sortingList.append(.init(values: .init()))
                callback(sortingList)
            }
        )
    }
}
