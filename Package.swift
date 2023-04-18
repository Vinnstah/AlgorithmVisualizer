// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let tca: Target.Dependency = .product(name: "ComposableArchitecture", package: "swift-composable-architecture")
let algorithms: Target.Dependency = .product(name: "Algorithms", package: "swift-algorithms")
let asyncExtension: Target.Dependency =  .product(name: "AsyncExtensions", package: "AsyncExtensions")

let package = Package(
    
    name: "AlgorithmVisualizer",
    platforms: [.iOS(.v16), .macOS(.v13)],
    products: [
        .library(
            name: "AppFeature",
            targets: ["AppFeature"]),
        .library(
            name: "ElementGeneratorClient",
            targets: ["ElementGeneratorClient"]),
            .library(
            name: "Grid",
            targets: ["Grid"]),
        .library(
            name: "HomeFeature",
            targets: ["HomeFeature"]),
        .library(
            name: "Node",
            targets: ["Node"]),
        .library(
            name: "PathfindingClient",
            targets: ["PathfindingClient"]),
        .library(
            name: "PathfindingFeature",
            targets: ["PathfindingFeature"]),
        .library(
            name: "SortingAlgorithmsClient",
            targets: ["SortingAlgorithmsClient"]),
        .library(
            name: "SortingFeature",
            targets: ["SortingFeature"]),
        .library(
            name: "UnsortedElements",
            targets: ["UnsortedElements"]),
    ],
    dependencies: [
        .package(url: "https://github.com/pointfreeco/swift-composable-architecture", branch: "prerelease/1.0"),
        .package(url: "https://github.com/apple/swift-algorithms.git", .upToNextMajor(from: "1.0.0")),
        .package(url: "https://github.com/nicklockwood/SwiftFormat", from: "0.50.9"),
        .package(url: "https://github.com/sideeffect-io/AsyncExtensions", from: "0.5.2")
    ],
    targets: [
        
        .target(
            name: "AppFeature",
            dependencies: [
                "HomeFeature",
                "PathfindingFeature",
                "SortingFeature",
                tca
            ]),
        .testTarget(
            name: "AppFeatureTests",
            dependencies: ["AppFeature"]),
        
            .target(
                name: "UnsortedElements",
                dependencies: [
                    algorithms,
                    tca
                ]),
        
            .target(
                name: "ElementGeneratorClient",
                dependencies: [
                    "UnsortedElements",
                    tca
                ]),
        .target(
        name: "Grid",
        dependencies: [
            "Node",
            tca,
        ]),
            .target(
                name: "HomeFeature",
                dependencies: [
                    tca
                ]),
        .testTarget(
            name: "HomeFeatureTests",
            dependencies: ["HomeFeature"]),
        
            .target(
                name: "SortingAlgorithmsClient",
                dependencies: [
                    "UnsortedElements",
                    asyncExtension,
                    tca
                ]),
        .target(
            name: "Node",
            dependencies: [
            ]),
        .target(
            name: "PathfindingClient",
            dependencies: [
                "Grid",
                "Node",
                tca,
            ]),
        .target(
            name: "PathfindingFeature",
            dependencies: [
                "Grid",
                "Node",
                "PathfindingClient",
                tca,
            ]),

        
            .target(
                name: "SortingFeature",
                dependencies: [
                    "UnsortedElements",
                    "ElementGeneratorClient",
                    "SortingAlgorithmsClient",
                    tca
                ]),
        .testTarget(
            name: "SortingFeatureTests",
            dependencies: ["SortingFeature"]),
    ]
)
