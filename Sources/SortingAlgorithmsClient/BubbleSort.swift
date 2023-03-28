import Foundation
import UnsortedElements
import AsyncExtensions

//public func _bubbleSort(
//    _ array: UnsortedElements,
//    _ swappedPairs: (UnsortedElements) async -> Void
//) async {
public func _bubbleSort(
    _ array: UnsortedElements,
    _ swappedPairs: (UnsortedElements) -> Void
) {
    
    var arrayToSort: UnsortedElements = array
    var numberOfChanges = 0
    
    for index in arrayToSort.values.indices {
        if index == arrayToSort.values.count - 1 {
            if numberOfChanges == 0 {
                return swappedPairs(arrayToSort)
                
            } else {
                return _bubbleSort(arrayToSort, swappedPairs)
            }
        }
        if arrayToSort.values[index + 1] < arrayToSort.values[index] {
            arrayToSort.values.swapAt(index, index + 1)
//            await swappedPairs([
//                .init(
//                    value: arrayToSort.values[index + 1].value,
//                    id: arrayToSort.values[index + 1].id,
//                    previousIndex: index,
//                    currentIndex: index + 1),
//                .init(
//                    value: arrayToSort.values[index].value,
//                    id: arrayToSort.values[index].id,
//                    previousIndex: index + 1,
//                    currentIndex: index)
//            ])
            swappedPairs(arrayToSort)
            numberOfChanges += 1
        }
    }
    guard numberOfChanges > 0 else {
        return swappedPairs(arrayToSort)
        
    }
    _bubbleSort(arrayToSort, swappedPairs)
}
