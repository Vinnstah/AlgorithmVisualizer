import ComposableArchitecture
import Foundation
import ChartModel

extension SortingAlgorithms: DependencyKey {
    
    static public var liveValue: SortingAlgorithms = Self(
        mergeSort: { array in
            return await merge(array)
        }
        )
}

public func merge(_ array: [ChartData.Elements]) async -> [ChartData.Elements] {
    guard !array.isEmpty && array.count > 1 else {
        return array
    }
    let middleIndex = array.count/2
    let firstArray = Array(array[0..<middleIndex])
    let secondArray = Array(array[middleIndex..<array.count])
    
    var firstHalf = await merge(firstArray)
    var secondHalf = await merge(secondArray)
    
    firstHalf.indices.forEach {
        firstHalf[$0].sortingStatus = .sortingInProgress
    }
    secondHalf.indices.forEach {
        secondHalf[$0].sortingStatus = .sortingInProgress
    }
    try! await Task.sleep(for: .milliseconds(10))
    
    print("first: \(firstHalf)")
    print("second: \(secondHalf)")
    return await mergeSort(&firstHalf, &secondHalf)
}

public func mergeSort(
    _ firstHalf: inout [ChartData.Elements],
    _ secondHalf: inout [ChartData.Elements]
) async -> [ChartData.Elements] {
    
    var sortedArray: [ChartData.Elements] = []
    while !firstHalf.isEmpty && !secondHalf.isEmpty {
        if firstHalf[0] > secondHalf[0] {
            sortedArray.append(secondHalf[0])
            sortedArray[sortedArray.count-1].sortingStatus = .finishedSorting
            secondHalf.remove(at: 0)
            
        } else {
            sortedArray.append(firstHalf[0])
            sortedArray[sortedArray.count-1].sortingStatus = .finishedSorting
            firstHalf.remove(at: 0)
        }
    }
    while firstHalf.count > 0 {
        sortedArray.append(firstHalf[0])
        sortedArray[sortedArray.count-1].sortingStatus = .finishedSorting
        firstHalf.remove(at: 0)
    }
    while secondHalf.count > 0 {
        sortedArray.append(secondHalf[0])
        sortedArray[sortedArray.count-1].sortingStatus = .finishedSorting
        secondHalf.remove(at: 0)
    }
    return sortedArray
}
