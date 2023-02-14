// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let tca: Target.Dependency = .product(name: "ComposableArchitecture", package: "swift-composable-architecture")

let package = Package(
    
    name: "AlgorithmVisualizer",
    platforms: [.iOS(.v16), .macOS(.v13)],
    products: [
        .library(
            name: "AppFeature",
            targets: ["AppFeature"]),
        .library(
            name: "SortingFeature",
            targets: ["SortingFeature"]),
    ],
    dependencies: [
        .package(url: "https://github.com/pointfreeco/swift-composable-architecture", branch: "prerelease/1.0")
    ],
    targets: [
        .target(
            name: "AppFeature",
            dependencies: [
            "SortingFeature",
            tca
            ]),
        .testTarget(
            name: "AppFeatureTests",
            dependencies: ["AppFeature"]),
        
            .target(
                name: "SortingFeature",
                dependencies: [
                tca
                ]),
    ]
)
