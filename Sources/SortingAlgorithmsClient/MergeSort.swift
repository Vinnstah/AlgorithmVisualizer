import Foundation
import UnsortedElements
import IdentifiedCollections

public func _merge(
     array: UnsortedElements,
//     queue: inout Queue<UnsortedElements.Element>,
    _ elementsToSort: ([UnsortedElements.Element]) async -> Void
) async -> UnsortedElements {
    guard !array.values.isEmpty && array.values.count > 1 else {
//    guard !queue.unsortedArray.isEmpty && queue.unsortedArray.count > 1 else {
                await elementsToSort([])
        return array
    }
    let middleIndex = array.values.count / 2
//    var firstArray = Queue(queue: queue.queue, unsortedArray: .init(uniqueElements: queue.unsortedArray.elements[0 ..< middleIndex]))
//    var secondArray = Queue(queue: queue.queue, unsortedArray: .init(uniqueElements: queue.unsortedArray.elements[middleIndex ..< queue.unsortedArray.count]))
    
    let firstArray = UnsortedElements(values: .init(uniqueElements: array.values[0 ..< middleIndex]))
    let secondArray = UnsortedElements(values: .init(uniqueElements: array.values[middleIndex ..< array.values.count]))
    
    var firstHalf = await _merge(array: firstArray, elementsToSort)
    var secondHalf = await _merge(array: secondArray, elementsToSort)
    
    let sortedArray = await mergeSort(&firstHalf, &secondHalf, elementsToSort)
    
//    var firstHalf = await merge(firstArray, elementsToSort, &queue)
//    var secondHalf = await merge(secondArray, elementsToSort, &queue)
//
//    await mergeSort(&firstHalf, &secondHalf, elementsToSort, &queue)
    return sortedArray
}

public func mergeSort(
    _ firstHalf: inout UnsortedElements,
    _ secondHalf: inout UnsortedElements,
//    _ queue: inout Queue<UnsortedElements.Element>,
    _ elementsToSort: ([UnsortedElements.Element]) async -> Void
) async -> UnsortedElements {
    var sortedArray: UnsortedElements = .init(values: [])
    while !firstHalf.values.isEmpty && !secondHalf.values.isEmpty {
        if firstHalf.values[0] > secondHalf.values[0] {
//            queue.addElementsToTheBackOfTheQueue(element: firstHalf.unsortedArray[0])
            print("IF #1")
            
            sortedArray.values.append(secondHalf.values[0])
//            guard let index = sortedArray.values.index(id: secondHalf.values[0].id) else { return }
//            sortedArray.values[index].currentIndex = index
//                        await elementsToSort(
//            //                sortedArray.values.elements
//                           [ UnsortedElements.Element(value: secondHalf.values[0].value, id: secondHalf.values[0].id, previousIndex: secondHalf.values[0].currentIndex, currentIndex: secondHalf.values[0].currentIndex)]
//                        )
            secondHalf.values.remove(at: 0)
            
        } else {
            print("IF #2")
//            queue.addElementsToTheBackOfTheQueue(element: secondHalf.unsortedArray[0])
            sortedArray.values.append(firstHalf.values[0])
//            guard let index = sortedArray.values.index(id: firstHalf.values[0].id) else {
//                print("ERRR")
//                return }
//            sortedArray.values[index].previousIndex = firstHalf.values[0].currentIndex
//
//            sortedArray.values[index].currentIndex = index
            firstHalf.values.remove(at: 0)
        }
    }
    while firstHalf.values.count > 0 {
        print("IF #3")
//        queue.addElementsToTheBackOfTheQueue(element: firstHalf.unsortedArray[0])
        sortedArray.values.append(firstHalf.values[0])
//        guard let index = sortedArray.values.index(id: firstHalf.values[0].id) else { print("ERRR")
//            return }
//        sortedArray.values[index].previousIndex = firstHalf.values[0].currentIndex
//        sortedArray.values[index].currentIndex = index
        firstHalf.values.remove(at: 0)
    }
    while secondHalf.values.count > 0 {
        print("IF #4")
//        fatalError()
//        queue.addElementsToTheBackOfTheQueue(element: secondHalf.unsortedArray[0])
        sortedArray.values.append(secondHalf.values[0])
//        guard let index = sortedArray.values.index(id: secondHalf.values[0].id) else { print("ERRR")
//            return }
//        sortedArray.values[index].previousIndex = secondHalf.values[0].currentIndex
//        sortedArray.values[index].currentIndex = index
        secondHalf.values.remove(at: 0)
    }
    
//    await elementsToSort(queue)
//    queue.queue.removeAll()
//    print(sortedArray.values.elements)
//    await elementsToSort(sortedArray.values.elements)
    print("IF #5")
    return sortedArray
}

extension UnsortedElements {
    public func getPreviousIndex(id: UUID) -> Int {
        return self.values.index(id: id) ?? -1
    }
}


public struct Queue<Element>: Equatable where Element: Identifiable {
    public static func == (lhs: Queue<Element>, rhs: Queue<Element>) -> Bool {
        lhs.queue[0].id == rhs.queue[0].id
    }
    
    
    public var queue: [IdentifiedArrayOf<Element>]
    public var unsortedArray: IdentifiedArrayOf<Element>
    
    public mutating func removeElementsFromTheFrontOfTheQueue() {
        queue.remove(at: queue.count-1)
    }
    
    public mutating func addElementsToTheBackOfTheQueue(element: Element) {
//        queue.first
//        if queue.count == 0 {
//            queue[0].insert(element, at: queue.endIndex)
//        }
        queue[queue.count - 1].insert(element, at: queue[queue.count - 1].endIndex)
//        queue.insert(element, at: queue.endIndex)
//        queue.insert(contentsOf: elements, at: queue.count-1)
    }
    
}
