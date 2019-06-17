// swift-tools-version:5.1

import PackageDescription

let package = Package(
  name: "ModalPresentationView",
  platforms: [
    .iOS(.v13),
  ],
  products: [
    .library(name: "ModalPresentationView", targets: ["ModalPresentationView"]),
  ],
  targets: [
    .target(name: "ModalPresentationView"),
  ]
)
