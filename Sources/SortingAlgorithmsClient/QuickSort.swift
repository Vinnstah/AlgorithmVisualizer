import Foundation
import UnsortedElements

public func _quickSort(
    _ arrayToSort: [UnsortedElements.Element],
    callback: ([UnsortedElements.Element]) -> Void
) -> [UnsortedElements.Element] {
    
    guard arrayToSort.count > 1 else {
        return arrayToSort
    }
        
    let pivot = arrayToSort[arrayToSort.count / 2]
    let less = arrayToSort.filter { $0 < pivot }
    let equal = arrayToSort.filter { $0 == pivot }
    let more = arrayToSort.filter { $0 > pivot }
    
    return _quickSort(less, callback: callback) + equal + _quickSort(more, callback: callback)
        
    }
