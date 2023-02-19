import ChartModel
import Foundation

public struct ElementGenerator {
    public typealias ElementGeneration = @Sendable (Int) -> [ChartData.Elements]
    
    public let generateElements: ElementGeneration
}
