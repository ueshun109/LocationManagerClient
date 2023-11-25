// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "LocationManagerClient",
  platforms: [.iOS(.v17)],
  products: [
    .library(
      name: "LocationManagerClient",
      targets: ["LocationManagerClient"]
    ),
  ],
  targets: [
    .target(name: "LocationManagerClient"),
    .testTarget(
      name: "LocationManagerClientTests",
      dependencies: ["LocationManagerClient"]
    ),
  ]
)
