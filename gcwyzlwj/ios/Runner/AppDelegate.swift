import UIKit
import Flutter
import AMapFoundationKit

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)
    AMapServices.shared().apiKey = "bd6e7c2182f28d71cc59ca386c18dab2"
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
