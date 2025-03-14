// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "DataLayer",
    platforms: [.macOS(.v14), .iOS(.v17), .watchOS(.v10)],
    products: [
        .library(
            name: "DataLayer",
            targets: ["DataLayer"]),
    ],
    dependencies: [
        .package(url: "https://github.com/apollographql/apollo-ios", .upToNextMinor(from: "0.51.2")),
        .package(path: "../DomainLayer")
    ],
    targets: [
        .target(
            name: "DataLayer",
            dependencies: [
                "DomainLayer",
                .product(name: "Apollo", package: "apollo-ios")
            ]
        ),
        .testTarget(
            name: "DataLayerTests",
            dependencies: [
                "DataLayer",
                "DomainLayer",
                .product(name: "TestUtils", package: "DomainLayer")
            ]
        ),
    ]
)
