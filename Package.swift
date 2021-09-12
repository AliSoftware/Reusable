// swift-tools-version:5.4
import PackageDescription

let package = Package(
    name: "Reusable",
    platforms: [.iOS(.v9), .tvOS(.v9)],
    products: [
        .library(name: "Reusable", targets: ["Reusable"])
    ],
    targets: [
      .target(
        name: "Reusable",
        path: "Sources"
      )
    ],
    swiftLanguageVersions: [.v4, .v5]
)
