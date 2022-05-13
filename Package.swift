// swift-tools-version: 5.6
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "Cache",
  products: [
    .library(
      name: "Cache",
      targets: ["Cache"])
  ],
  dependencies: [],
  targets: [
    .target(
      name: "Cache",
      dependencies: []),
    .testTarget(
      name: "CacheTests",
      dependencies: ["Cache"]),
  ]
)
