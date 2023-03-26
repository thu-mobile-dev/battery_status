import 'battery_status_platform_interface.dart';

class BatteryStatus {
  Future<String?> getPlatformVersion() {
    return BatteryStatusPlatform.instance.getPlatformVersion();
  }

  Future<bool?> isCharging() {
    return BatteryStatusPlatform.instance.isCharging();
  }

  Future<double?> value() {
    return BatteryStatusPlatform.instance.value();
  }
}
