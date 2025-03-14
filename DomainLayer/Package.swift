// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "DomainLayer",
    platforms: [.iOS(.v17), .macOS(.v14), .watchOS(.v10)],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "DomainLayer",
            targets: ["DomainLayer"]),
        .library(
            name: "TestUtils",
            targets: ["TestUtils"]
        )
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "DomainLayer"),
        .target(name: "TestUtils", dependencies: ["DomainLayer"]),
        .testTarget(
            name: "DomainLayerTests",
            dependencies: ["DomainLayer", "TestUtils"]
        ),
    ]
)
