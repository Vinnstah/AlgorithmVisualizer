import Foundation
import UnsortedElements
import IdentifiedCollections

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

//
//public struct Queue<Foo> where Foo: Comparable {
//    
//    public var queue: [[Foo]]
//    
//    public mutating func removeElementsFromTheFrontOfTheQueue() -> [[Foo]] {
//        queue.remove(at: 0)
//        return queue
//    }
//    
//    public mutating func addElementsToTheBackOfTheQueue(elements: [Foo]) -> [[Foo]] {
//        queue.insert(elements, at: queue.values.count-1)
//        return queue
//    }
//    
//}
//struct Test {
//    var testQ: Queue<Foo>
//    var testQ = testQ.addElementsToTheBackOfTheQueue(elements: [
//        .init(value: 2, id: UUID(), initialPostition: 4, currentPostition: testQ.queue.firstIndex(where: { $0.id == id }) ?? -1) ,
//        .init(value: 5, id: UUID(), initialPostition: 2, currentPostition: testQ.queue.index(where: { $0.id == id }))
//    ])
//    
//}
