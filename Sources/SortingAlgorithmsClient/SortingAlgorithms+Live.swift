import ComposableArchitecture
import Foundation

extension SortingAlgorithms: DependencyKey {
    
    static public var liveValue: SortingAlgorithms = Self(
        mergeSort: { array in
            
            return merge(array)
        })
}

public func merge(_ array: [Int]) -> [Int] {
    guard !array.isEmpty && array.count > 1 else {
        return array
    }
    let middleIndex = array.count/2
    let firstArray = Array(array[0..<middleIndex])
    print(firstArray)
    let secondArray = Array(array[middleIndex..<array.count])
    print(secondArray)
    var a = merge(firstArray)
    var b = merge(secondArray)

    return mergeSort(&a, &b)
}

public func mergeSort(_ a: inout [Int], _ b: inout [Int]) -> [Int] {
    
    var sortedArray: [Int] = []
    while !a.isEmpty && !b.isEmpty {
            if a[0] > b[0] {
                sortedArray.append(b[0])
                
                b.remove(at: 0)
            } else {
                sortedArray.append(a[0])
                a.remove(at: 0)
            }
        }
        while a.count > 0 {
            sortedArray.append(a[0])
            a.remove(at: 0)
        }
        while b.count > 0 {
            sortedArray.append(b[0])
            b.remove(at: 0)
        }
        return sortedArray
}

