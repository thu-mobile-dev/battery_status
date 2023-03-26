import Flutter
import UIKit

public class BatteryStatusPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "battery_status", binaryMessenger: registrar.messenger())
    let instance = BatteryStatusPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    if call.method == "getPlatformVersion" {
      result("iOS " + UIDevice.current.systemVersion)
    } else if call.method == "isCharging" {
      UIDevice.current.isBatteryMonitoringEnabled = true
      if UIDevice.current.batteryState == .unknown {
        result(nil)
      } else if UIDevice.current.batteryState == .charging || UIDevice.current.batteryState == .full {
        result(true)
      } else {
        result(false)
      }
    } else if call.method == "value" {
      UIDevice.current.isBatteryMonitoringEnabled = true
      if UIDevice.current.batteryState == .unknown {
        result(nil)
      } else {
        result(Double(UIDevice.current.batteryLevel))
      }
    } else {
      result(FlutterMethodNotImplemented)
    }
  }
}
