// swift-tools-version: 5.6
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "Cache",
  products: [
    .library(name: "Cache", targets: ["Cache"])
  ],
  dependencies: [
    .package(url: "https://github.com/pointfreeco/xctest-dynamic-overlay", from: "0.2.1")
  ],
  targets: [
    .target(
      name: "Cache",
      dependencies: [
        .product(name: "XCTestDynamicOverlay", package: "xctest-dynamic-overlay")
      ]
    ),
    .testTarget(
      name: "CacheTests",
      dependencies: ["Cache"]),
  ]
)
