// swift-tools-version:5.0
import PackageDescription

let package = Package(
    name: "Reusable",
    platforms: [.iOS(.v8), .tvOS(.v9)],
    products: [
        .library(name: "Reusable", targets: ["Reusable"])
    ],
    targets: [
      .target(
        name: "Reusable",
        path: "",
        sources: ["Sources"]
      )
    ],
    swiftLanguageVersions: [.v4, .v5]
)
