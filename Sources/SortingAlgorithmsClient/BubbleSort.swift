import ChartModel
import Foundation

public func bubble(array: [ChartData.Elements]) async  -> [ChartData.Elements] {
    fatalError("NOT WORKING YET")
    var sortedArray: [ChartData.Elements] = array
    var numberOfChanges: Int = 0
    
    for index in sortedArray.indices {
        if sortedArray[index] < sortedArray[index + 1] {
            guard index < (sortedArray.count - 1) && numberOfChanges < 1 else {
                return sortedArray
            }
            sortedArray.swapAt(index, index + 1)
            numberOfChanges += 1
        }
    }
    guard numberOfChanges > 0 else  {
        return sortedArray
    }
    
    return await bubble(array: sortedArray)
    
}
