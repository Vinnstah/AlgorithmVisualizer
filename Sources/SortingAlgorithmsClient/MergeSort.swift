import Foundation
import UnsortedElements
import IdentifiedCollections

public func merge(
    _ array: UnsortedElements,
    _ elementsToSort: ([UnsortedElements.Element]) async -> Void
) async -> UnsortedElements {
    guard !array.values.isEmpty && array.values.count > 1 else {
//        await elementsToSort([])
        return array
    }
    let middleIndex = array.values.count / 2
    let firstArray = UnsortedElements(values: .init(uniqueElements: array.values[0 ..< middleIndex]))
    let secondArray = UnsortedElements(values: .init(uniqueElements: array.values[middleIndex ..< array.values.count]))

    var firstHalf = await merge(firstArray, elementsToSort)
    var secondHalf = await merge(secondArray, elementsToSort)

     await mergeSort(&firstHalf, &secondHalf, elementsToSort)
    return array
}

public func mergeSort(
    _ firstHalf: inout UnsortedElements,
    _ secondHalf: inout UnsortedElements,
    _ elementsToSort: ([UnsortedElements.Element]) async -> Void
) async -> Void {
    var sortedArray: UnsortedElements = .init(values: [])
    while !firstHalf.values.isEmpty && !secondHalf.values.isEmpty {
        if firstHalf.values[0] > secondHalf.values[0] {
            sortedArray.values.append(secondHalf.values[0])
            await elementsToSort(
                sortedArray.values.elements
//                UnsortedElements.Element(value: secondHalf.values[0].value, id: secondHalf.values[0].id, previousIndex: secondHalf.values[0].currentIndex, currentIndex: secondHalf.values[0].currentIndex)
            )
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
    return
}

extension UnsortedElements {
    public func getPreviousIndex(id: UUID) -> Int {
        return self.values.index(id: id) ?? -1
    }
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
