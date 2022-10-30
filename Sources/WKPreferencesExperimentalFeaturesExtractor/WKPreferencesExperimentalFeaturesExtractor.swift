import WebKit

@main
public struct WKPreferencesExperimentalFeaturesExtractor {
  static let dyldFrameworkPath = ProcessInfo.processInfo.environment["DYLD_FRAMEWORK_PATH"]
  static let safariFrameworksPath = "/Applications/Safari.app/Contents/Frameworks/"
  static let safariBetaFrameworksPath = "/Library/Apple/System/Library/StagedFrameworks/Safari/"
  static let safariTechnologyPreviewFrameworksPath = "/Applications/Safari Technology Preview.app/Contents/Frameworks/"

  public static func main() {
    let defaultsDomain: String

    switch dyldFrameworkPath {
      case safariFrameworksPath, safariBetaFrameworksPath: defaultsDomain = "com.apple.Safari"
      case safariTechnologyPreviewFrameworksPath: defaultsDomain = "com.apple.SafariTechnologyPreview"
      default:
      print(
        """
        Expected `DYLD_FRAMEWORK_PATH` to be set to:
        1. Safari: \(safariFrameworksPath)
        2. Safari Beta: \(safariBetaFrameworksPath)
        3. Safari Technology Preview: \(safariTechnologyPreviewFrameworksPath)
        """
      )
      exit(1)
    }

    let featuresToDisable: [String] = [
      "IsThirdPartyCookieBlockingDisabled",
      "IsFirstPartyWebsiteDataRemovalDisabled",
      "CFNetworkNetworkLoaderEnabled",
      "PreferPageRenderingUpdatesNear60FPSEnabled",
      "PrivateClickMeasurementDebugModeEnabled"
    ]

    let experimentalFeatures = WKPreferences.self.value(forKey: "_experimentalFeatures")

    guard let experimentalFeatures = experimentalFeatures as? [NSObject] else {
      fatalError("Expected \(type(of: experimentalFeatures)) to be a subclass of \([NSObject].self)")
    }

    print("Total Features:", experimentalFeatures.count, "\n")

    experimentalFeatures.forEach {
      guard let name = $0.value(forKey: "name") as? String else {
        fatalError("Unable to extract `name` for feature: \($0)")
      }

      guard let key = $0.value(forKey: "key") as? String else {
        fatalError("Unable to extract `key` for feature: \($0)")
      }

      let value = featuresToDisable.contains(key) ? "no" : "yes"
      print("defaults write \(defaultsDomain) WebKitExperimental\(key) -bool \(value)", terminator: ";")
    }
  }
}
