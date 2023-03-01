import Foundation
import UnsortedElements

public func bubbleSortStream(
    array: UnsortedElements,
    emitElements: @escaping (_ elements: @escaping (() async -> [UnsortedElements.Element])) async -> Void)
async -> UnsortedElements {
    
    var sortedArray: UnsortedElements = array
    var numberOfChanges = 0
    
    for index in sortedArray.values.indices {
        if index == sortedArray.values.count - 1 {
            if numberOfChanges == 0 {
                await emitElements {
                    return []
                }
                return sortedArray
            } else {
                return await bubbleSortStream(
                    array: sortedArray,
                    emitElements: { elements in await emitElements(elements) }
                )
            }
        }
        if sortedArray.values[index + 1] < sortedArray.values[index] {
            sortedArray.values.swapAt(index, index + 1)
            await emitElements {
                return [
                    .init(
                        value: sortedArray.values[index + 1].value,
                        id: sortedArray.values[index + 1].id,
                        previousIndex: index + 1,
                        currentIndex: index),
                    
                        .init(
                            value: sortedArray.values[index].value,
                            id: sortedArray.values[index].id,
                            previousIndex: index,
                            currentIndex: index + 1)
                ]
            }
            numberOfChanges += 1
        }
    }
    guard numberOfChanges > 0 else {
        
        return sortedArray
    }
    
    return await bubbleSortStream(array: sortedArray, emitElements: { elements in await emitElements(elements) })
}
