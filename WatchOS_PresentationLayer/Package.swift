// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "WatchOS_PresentationLayer",
    platforms: [.watchOS(.v10)],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "WatchOS_PresentationLayer",
            targets: ["WatchOS_PresentationLayer"]),
    ],
    dependencies: [.package(path: "../PresentationLayer"), .package(path: "../DomainLayer")],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "WatchOS_PresentationLayer",
            dependencies: ["PresentationLayer", "DomainLayer"]
        ),
        .testTarget(
            name: "WatchOS_PresentationLayerTests",
            dependencies: ["WatchOS_PresentationLayer", "PresentationLayer", "DomainLayer"]
        ),
    ]
)
