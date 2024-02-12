// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "MyLibrary",
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "MyLibrary",
            
            targets: ["MyLibrary"]),
        
    ],
    dependencies: [.package(url: "https://github.com/Shopify/mobile-buy-sdk-ios.git", from: .init(stringLiteral: "11.3.0"))],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "MyLibrary", dependencies: [.product(name: "Buy", package: "mobile-buy-sdk-ios")]),
        .testTarget(
            name: "MyLibraryTests",
            dependencies: ["MyLibrary"]),
    ]
)
