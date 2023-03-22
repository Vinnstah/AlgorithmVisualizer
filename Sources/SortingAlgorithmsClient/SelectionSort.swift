import Foundation
import UnsortedElements

public func _selectionSort(
    _ arrayToSort: inout UnsortedElements,
    _ count: Int,
    _ elementsToSort: (UnsortedElements) async -> Void
) async -> Void {
    
    guard !arrayToSort.values.isEmpty && arrayToSort.values.count > 1 else {
        await elementsToSort(arrayToSort)
        return 
    }
    
    while !arrayToSort.isSorted(order: .increasing) && count < arrayToSort.values.count {
        for index in arrayToSort.values.elements.indices {
            if arrayToSort.values.elements[index].value > arrayToSort.values.elements[count].value {
                arrayToSort.values.swapAt(index, count)
            }
        }
        await elementsToSort(arrayToSort)
        return await _selectionSort(&arrayToSort, count + 1, elementsToSort)
    }
}
