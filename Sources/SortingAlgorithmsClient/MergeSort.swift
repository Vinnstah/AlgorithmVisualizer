import Foundation
import UnsortedElements
import IdentifiedCollections

public func _merge(
    array: UnsortedElements,
    _ elementsToSort: (UnsortedElements) -> Void
) -> UnsortedElements {
    guard array.values.count > 1 else {
        return array
    }
    let middleIndex = array.values.count / 2
    
    let firstArray = UnsortedElements(values: .init(uniqueElements: array.values[0 ..< middleIndex]))
    let secondArray = UnsortedElements(values: .init(uniqueElements: array.values[middleIndex ..< array.values.count]))
    
    var firstHalf = _merge(array: firstArray, elementsToSort)
    var secondHalf = _merge(array: secondArray, elementsToSort)
    
    let sortedArray = mergeSort(&firstHalf, &secondHalf, elementsToSort)
    
    return sortedArray
}

public func mergeSort(
    _ firstHalf: inout UnsortedElements,
    _ secondHalf: inout UnsortedElements,
    _ elementsToSort: (UnsortedElements) -> Void
) -> UnsortedElements {
    var sortedArray: UnsortedElements = .init(values: [])
    while !firstHalf.values.isEmpty && !secondHalf.values.isEmpty {
        if firstHalf.values[0] > secondHalf.values[0] {
            sortedArray.values.append(secondHalf.values[0])
            secondHalf.values.remove(at: 0)
            
        } else {
            sortedArray.values.append(firstHalf.values[0])
            firstHalf.values.remove(at: 0)
        }
    }
    while firstHalf.values.count > 0 {
        sortedArray.values.append(firstHalf.values[0])
        firstHalf.values.remove(at: 0)
    }
    while secondHalf.values.count > 0 {
        sortedArray.values.append(secondHalf.values[0])
        secondHalf.values.remove(at: 0)
    }
    elementsToSort(sortedArray)
    return sortedArray
}

