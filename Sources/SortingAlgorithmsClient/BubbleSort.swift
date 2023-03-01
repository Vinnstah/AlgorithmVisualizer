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

public func bubbleStream(
    array: UnsortedElements,
    emitAction: @escaping (_ test: @escaping (() async -> [Foo])) async -> Void)
async -> UnsortedElements {
    
    var sortedArray: UnsortedElements = array
    var numberOfChanges = 0
    
    for index in sortedArray.values.indices {
        if index == sortedArray.values.count - 1 {
            if numberOfChanges == 0 {
                        await emitAction {
                           return []
                        }
                print("DODODODO")
                return sortedArray
            } else {
                return await bubbleStream(array: sortedArray, emitAction: { test in await emitAction(test) })
            }
        }
        if sortedArray.values[index + 1] < sortedArray.values[index] {
            sortedArray.values.swapAt(index, index + 1)
            print("ITERATION \(index)")
            await emitAction {
               return [
                    .init(value: sortedArray.values[index + 1].value, id: sortedArray.values[index + 1].id, initialPostition: index + 1, currentPostition: index),
                    .init(value: sortedArray.values[index].value, id: sortedArray.values[index].id, initialPostition: index, currentPostition: index + 1)
                ]
            }
            numberOfChanges += 1
        }
    }
    guard numberOfChanges > 0 else {
        print("DONENEE")

        return sortedArray
    }
    
    return await bubbleStream(array: sortedArray, emitAction: { test in await emitAction(test) })
}
