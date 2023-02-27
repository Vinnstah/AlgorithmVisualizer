import Foundation
import UnsortedElements

public func bubble(array: UnsortedElements) async -> UnsortedElements {
    var sortedArray: UnsortedElements = array
    var numberOfChanges = 0

    for index in sortedArray.values.indices {
        if index == sortedArray.values.count - 1 {
            if numberOfChanges == 0 {
                return sortedArray
            } else {
                return await bubble(array: sortedArray)
            }
        }
        if sortedArray.values[index + 1] < sortedArray.values[index] {
            sortedArray.values.swapAt(index, index + 1)
            numberOfChanges += 1
        }
    }
    guard numberOfChanges > 0 else {
        return sortedArray
    }

    return await bubble(array: sortedArray)
}

public func bubbleStream(array: UnsortedElements, emitAction: @escaping ([UnsortedElements.Element]) -> Void) async -> UnsortedElements {
    fatalError()
    var sortedArray: UnsortedElements = array
    var numberOfChanges = 0

    for index in sortedArray.values.indices {
        if index == sortedArray.values.count - 1 {
            if numberOfChanges == 0 {
                return sortedArray
            } else {
                return await bubble(array: sortedArray)
            }
        }
        if sortedArray.values[index + 1] < sortedArray.values[index] {
            sortedArray.values.swapAt(index, index + 1)
            numberOfChanges += 1
        }
    }
    guard numberOfChanges > 0 else {
        return sortedArray
    }

    return await bubble(array: sortedArray)
}
