// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "NammaAppUI",
    platforms: [.iOS(.v17)],
    products: [
        .library(
            name: "NammaAppUI",
            targets: ["NammaAppUI"]),
    ],
    dependencies: [
        .package(
            url: "https://github.com/onevcat/Kingfisher.git",
            from: "8.0.0"
        )
    ],
    targets: [
        .target(
            name: "NammaAppUI",
            dependencies: [
                .product(name: "Kingfisher", package: "Kingfisher")
            ],
            resources: [
                .process("Assets.xcassets")
            ]
        ),
        .testTarget(
            name: "NammaAppUITests",
            dependencies: ["NammaAppUI"]
        )
    ]
)
