import ChartModel
import Foundation

public func merge(_ array: ChartData) async -> ChartData {
    guard !array.values.isEmpty && array.values.count > 1 else {
        return array
    }
    let middleIndex = array.values.count/2
    let firstArray = ChartData(values: .init(uniqueElements: array.values[0..<middleIndex]))
    let secondArray = ChartData(values: .init(uniqueElements: array.values[middleIndex..<array.values.count]))
    
    var firstHalf = await merge(firstArray)
    var secondHalf = await merge(secondArray)
    
    firstHalf.values.indices.forEach {
        firstHalf.values[$0].sortingStatus = .sortingInProgress
    }
    secondHalf.values.indices.forEach {
        secondHalf.values[$0].sortingStatus = .sortingInProgress
    }
    
    return await mergeSort(&firstHalf, &secondHalf)
}

public func mergeSort(
    _ firstHalf: inout ChartData,
    _ secondHalf: inout ChartData
) async -> ChartData {
    
    var sortedArray: ChartData = .init(values: [])
    while !firstHalf.values.isEmpty && !secondHalf.values.isEmpty {
        if firstHalf.values[0] > secondHalf.values[0] {
            sortedArray.values.append(secondHalf.values[0])
            sortedArray.values[sortedArray.values.count-1].sortingStatus = .finishedSorting
            secondHalf.values.remove(at: 0)
            
        } else {
            sortedArray.values.append(firstHalf.values[0])
            sortedArray.values[sortedArray.values.count-1].sortingStatus = .finishedSorting
            firstHalf.values.remove(at: 0)
        }
    }
    while firstHalf.values.count > 0 {
        sortedArray.values.append(firstHalf.values[0])
        sortedArray.values[sortedArray.values.count-1].sortingStatus = .finishedSorting
        firstHalf.values.remove(at: 0)
    }
    while secondHalf.values.count > 0 {
        sortedArray.values.append(secondHalf.values[0])
        sortedArray.values[sortedArray.values.count-1].sortingStatus = .finishedSorting
        secondHalf.values.remove(at: 0)
    }
    sortedArray.sorted = true
    return sortedArray
}
