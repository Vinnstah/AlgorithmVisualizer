import ChartModel
import Foundation

public func bubble(array: ChartData) async -> ChartData {
    var sortedArray: ChartData = array
    var numberOfChanges: Int = 0
    
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
            sortedArray.values[index].sortingStatus = .finishedSorting
            sortedArray.values[index + 1].sortingStatus = .finishedSorting
            numberOfChanges += 1
        }
        sortedArray.values[index].sortingStatus = .finishedSorting
    }
    guard numberOfChanges > 0 else  {
        sortedArray.sorted = true
        return sortedArray
    }
    
    return await bubble(array: sortedArray)
    
}
//public func bubble(array: [ChartData.Elements]) async -> [ChartData.Elements] {
//    var sortedArray: [ChartData.Elements] = array
//    var numberOfChanges: Int = 0
//
//    for index in sortedArray.indices {
//        if index == sortedArray.count - 1 {
//            if numberOfChanges == 0 {
//                return sortedArray
//            } else {
//                return await bubble(array: sortedArray)
//            }
//        }
//        if sortedArray[index + 1] < sortedArray[index] {
//            sortedArray.swapAt(index, index + 1)
//            sortedArray[index].sortingStatus = .finishedSorting
//            sortedArray[index + 1].sortingStatus = .finishedSorting
//            numberOfChanges += 1
//        }
//        sortedArray[index].sortingStatus = .finishedSorting
//    }
//    guard numberOfChanges > 0 else  {
//        return sortedArray
//    }
//
//    return await bubble(array: sortedArray)
//
//}
