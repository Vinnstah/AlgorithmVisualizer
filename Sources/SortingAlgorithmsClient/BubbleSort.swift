import Foundation
import UnsortedElements
import AsyncExtensions

public func _bubbleSort(
    _ array: UnsortedElements,
    _ callbackWithSortingProgress: (UnsortedElements) -> Void
) {
    
    var arrayToSort: UnsortedElements = array
    var numberOfChanges = 0
    
    for index in arrayToSort.values.indices {
        if index == arrayToSort.values.count - 1 {
            if numberOfChanges == 0 {
                return callbackWithSortingProgress(arrayToSort)
            } else {
                return _bubbleSort(arrayToSort, callbackWithSortingProgress)
            }
        }
        if arrayToSort.values[index + 1] < arrayToSort.values[index] {
            arrayToSort.values.swapAt(index, index + 1)
            callbackWithSortingProgress(arrayToSort)
            numberOfChanges += 1
        }
    }
    guard numberOfChanges > 0 else {
        return callbackWithSortingProgress(arrayToSort)
        
    }
    _bubbleSort(arrayToSort, callbackWithSortingProgress)
}
