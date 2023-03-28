import UnsortedElements
import Foundation

public func _insertionSort(
    _ arrayToSort: UnsortedElements
) -> Void {
    guard arrayToSort.values.count > 1 &&
            !arrayToSort.isSorted(order: .increasing)
    else {
        return
    }
    
    for index in arrayToSort.values.indices {
        if arrayToSort.values.elements[index + 1].value < arrayToSort.values.elements[index].value {
        }
    }
}
