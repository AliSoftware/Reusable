// swift-tools-version:5.0
import PackageDescription

// Note: SPM support is broken until we can add dependency on UIKit.

let package = Package(
    name: "Reusable",
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
