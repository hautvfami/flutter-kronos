import Flutter
import UIKit
import Kronos

public class SwiftFlutterKronosPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "flutter_kronos", binaryMessenger: registrar.messenger())
    let instance = SwiftFlutterKronosPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    switch call.method {
    case "sync":
        Clock.sync()
        result(nil)
    case "getCurrentTimeMs":
        let now = Clock.now?.timeIntervalSince1970 ?? Date().timeIntervalSince1970
        result(Int64(now*1000))
    case "getCurrentNtpTimeMs":
        guard let ntpTime = Clock.now else {
            result(nil)
            return
        }
        result(Int64(ntpTime.timeIntervalSince1970*1000))
    default:
        result(FlutterMethodNotImplemented);
    }
  }
}
