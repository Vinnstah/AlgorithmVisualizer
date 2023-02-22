import Foundation
import UnsortedElements

public func merge(_ array: UnsortedElements) async -> UnsortedElements {
    guard !array.values.isEmpty && array.values.count > 1 else {
        return array
    }
    let middleIndex = array.values.count / 2
    let firstArray = UnsortedElements(values: .init(uniqueElements: array.values[0 ..< middleIndex]))
    let secondArray = UnsortedElements(values: .init(uniqueElements: array.values[middleIndex ..< array.values.count]))

    var firstHalf = await merge(firstArray)
    var secondHalf = await merge(secondArray)

    return await mergeSort(&firstHalf, &secondHalf)
}

public func mergeSort(
    _ firstHalf: inout UnsortedElements,
    _ secondHalf: inout UnsortedElements
) async -> UnsortedElements {
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
    return sortedArray
}
