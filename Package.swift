// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "adventOfCode2023",
    platforms: [
        .macOS(.v14 ),
    ],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "adventOfCode2023",
            targets: ["adventOfCode2023"]),
    ],
    dependencies: [
        .package(url: "https://github.com/pointfreeco/swift-parsing", .upToNextMajor(from: "0.13.0")),
        .package(url: "https://github.com/nschum/SwiftHamcrest", .upToNextMajor(from: "2.2.4")),
        .package(url: "https://github.com/apple/swift-collections.git", .upToNextMinor(from: "1.0.0")),
        .package(url: "https://github.com/davecom/SwiftPriorityQueue", .upToNextMinor(from: "1.3.0")),
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "adventOfCode2023"),
        .testTarget(
            name: "adventOfCode2023Tests",
            dependencies: [
                "adventOfCode2023",
                .product(name: "Parsing", package: "swift-parsing"),
                .product(name: "SwiftHamcrest", package: "SwiftHamcrest"),
                .product(name: "Collections", package: "swift-collections"),
                .product(name: "SwiftPriorityQueue", package: "SwiftPriorityQueue"),
            ],
            resources: [
                .process("dataFiles") // Process resources in the "Resources" folder
            ])
    ]
)
