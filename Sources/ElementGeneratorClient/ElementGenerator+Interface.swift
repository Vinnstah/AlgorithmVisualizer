import ChartModel
import Foundation

public struct ElementGenerator {
    public typealias ElementGeneration = @Sendable (Int) -> [ChartData.Element]
    
    public let generateElements: ElementGeneration
}
