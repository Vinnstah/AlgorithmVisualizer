import UnsortedElements
import Foundation

public func _insertionSort(
    _ arrayToSort: inout UnsortedElements,
    _ callbackWithSortingProgress: (UnsortedElements) -> Void
) -> Void {
    guard arrayToSort.values.count > 1 &&
            !arrayToSort.isSorted(order: .increasing)
    else {
        return
    }
    var sortedArray: UnsortedElements = .init(values: .init())
    
    for unsortedElementIndex in arrayToSort.values.indices {
        if unsortedElementIndex == 0 {
            sortedArray.values.append(arrayToSort.values.elements[unsortedElementIndex])
        }
        print(unsortedElementIndex)
        for sortedElementIndex in sortedArray.values.indices {
            guard !sortedArray.values.isEmpty else {
                sortedArray.values.append(arrayToSort.values.elements[unsortedElementIndex])
                return
            }
            if arrayToSort.values.elements[unsortedElementIndex] <= sortedArray.values.elements[sortedElementIndex] {
                sortedArray.values.insert(arrayToSort.values.elements[unsortedElementIndex], at: sortedElementIndex)
                callbackWithSortingProgress(sortedArray)
            }
            if sortedElementIndex == sortedArray.values.count - 1 {
                sortedArray.values.append(arrayToSort.values.elements[unsortedElementIndex])
            }
        }
    }
    
}
