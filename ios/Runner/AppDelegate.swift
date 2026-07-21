import Flutter
import UIKit

@main
@objc class AppDelegate: FlutterAppDelegate, FlutterImplicitEngineDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    if #available(iOS 10.0, *) {
      UNUserNotificationCenter.current().delegate = self as? UNUserNotificationCenterDelegate
    }
    
    let controller : FlutterViewController = window?.rootViewController as! FlutterViewController
    let themeChannel = FlutterMethodChannel(name: "sn.smapp.priorise/theme", binaryMessenger: controller.binaryMessenger)
    
    themeChannel.setMethodCallHandler({
      (call: FlutterMethodCall, result: @escaping FlutterResult) -> Void in
      if call.method == "setTheme" {
          if let args = call.arguments as? [String: Any],
             let theme = args["theme"] as? String {
              if #available(iOS 13.0, *) {
                  var style: UIUserInterfaceStyle = .unspecified
                  if theme == "light" {
                      style = .light
                  } else if theme == "dark" {
                      style = .dark
                  }
                  self.window?.overrideUserInterfaceStyle = style
              }
          }
          result(nil)
      } else {
          result(FlutterMethodNotImplemented)
      }
    })

    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }

  func didInitializeImplicitFlutterEngine(_ engineBridge: FlutterImplicitEngineBridge) {
    GeneratedPluginRegistrant.register(with: engineBridge.pluginRegistry)
  }
}
