import Foundation
import UnsortedElements
import IdentifiedCollections

public func merge(
    _ array: UnsortedElements,
    emitElements: @escaping (_ elements: @escaping ((()) async -> [UnsortedElements.Element])) async -> Void)
async -> UnsortedElements {
    guard !array.values.isEmpty && array.values.count > 1 else {
        await emitElements {
            array.values.elements
        }
        return array
    }
    let middleIndex = array.values.count / 2
    let firstArray = UnsortedElements(values: .init(uniqueElements: array.values[0 ..< middleIndex]))
    let secondArray = UnsortedElements(values: .init(uniqueElements: array.values[middleIndex ..< array.values.count]))

    var firstHalf = await merge(firstArray, emitElements: { elements in await emitElements(elements) })
    var secondHalf = await merge(secondArray, emitElements: { elements in await emitElements(elements) })

    return await mergeSort(&firstHalf, &secondHalf, emitElements: emitElements)
}

public func mergeSort(
    _ firstHalf: inout UnsortedElements,
    _ secondHalf: inout UnsortedElements,
    emitElements: (@escaping ((()) async ->  [UnsortedElements.Element])) async -> Void
) async -> UnsortedElements {
    var sortedArray: UnsortedElements = .init(values: [])
    while !firstHalf.values.isEmpty && !secondHalf.values.isEmpty {
        if firstHalf.values[0] > secondHalf.values[0] {
            await emitElements {
                fatalError()
                [
//                    .init(
//                        value: firstHalf.values[0].value,
//                        id: firstHalf.values[0].id,
//                        previousIndex: firstHalf.getPreviousIndex(id: firstHalf.values[0].id),
//                        currentIndex: firstHalf.values[0].currentIndex
//                    )
                ]
            }
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
