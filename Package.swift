// swift-tools-version: 5.7
import PackageDescription

let package = Package(
  name: "WKPreferencesExperimentalFeaturesExtractor",
  dependencies: [],
  targets: [
    .executableTarget(
      name: "WKPreferencesExperimentalFeaturesExtractor",
      dependencies: []
    ),
    .testTarget(
      name: "WKPreferencesExperimentalFeaturesExtractorTests",
      dependencies: ["WKPreferencesExperimentalFeaturesExtractor"]
    )
  ]
)
