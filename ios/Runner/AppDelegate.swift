import Flutter
import UIKit

@main
@objc class AppDelegate: FlutterAppDelegate, FlutterImplicitEngineDelegate {
  private let googleSignInChannelName = "io.padisoft.superkauf/google_sign_in_config"
  private var googleSignInChannel: FlutterMethodChannel?

  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }

  func didInitializeImplicitFlutterEngine(_ engineBridge: FlutterImplicitEngineBridge) {
    GeneratedPluginRegistrant.register(with: engineBridge.pluginRegistry)

    let channel = FlutterMethodChannel(
      name: googleSignInChannelName,
      binaryMessenger: engineBridge.applicationRegistrar.messenger()
    )

    channel.setMethodCallHandler { [weak self] call, result in
      guard call.method == "getGoogleSignInConfigurationStatus" else {
        result(FlutterMethodNotImplemented)
        return
      }

      result(self?.googleSignInConfigurationStatus())
    }

    googleSignInChannel = channel
  }

  private func googleSignInConfigurationStatus() -> [String: Any] {
    guard let googleServiceInfoPath = Bundle.main.path(
      forResource: "GoogleService-Info",
      ofType: "plist"
    ) else {
      return [
        "configured": false,
        "message": "Google Sign-In is not configured. Add GoogleService-Info.plist to ios/Runner."
      ]
    }

    guard
      let googleServiceInfo = NSDictionary(contentsOfFile: googleServiceInfoPath) as? [String: Any]
    else {
      return [
        "configured": false,
        "message": "GoogleService-Info.plist could not be read."
      ]
    }

    guard let clientId = googleServiceInfo["CLIENT_ID"] as? String, !clientId.isEmpty else {
      return [
        "configured": false,
        "message": "GoogleService-Info.plist is missing CLIENT_ID."
      ]
    }

    guard
      let reversedClientId = googleServiceInfo["REVERSED_CLIENT_ID"] as? String,
      !reversedClientId.isEmpty
    else {
      return [
        "configured": false,
        "message": "GoogleService-Info.plist is missing REVERSED_CLIENT_ID."
      ]
    }

    let urlTypes = Bundle.main.object(forInfoDictionaryKey: "CFBundleURLTypes") as? [[String: Any]] ?? []
    let urlSchemes = urlTypes
      .compactMap { $0["CFBundleURLSchemes"] as? [String] }
      .flatMap { $0 }

    guard urlSchemes.contains(reversedClientId) else {
      return [
        "configured": false,
        "message": "The app is missing the Google URL scheme from REVERSED_CLIENT_ID."
      ]
    }

    return [
      "configured": true,
      "clientId": clientId
    ]
  }
}
