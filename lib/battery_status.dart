
import 'battery_status_platform_interface.dart';

class BatteryStatus {
  Future<String?> getPlatformVersion() {
    return BatteryStatusPlatform.instance.getPlatformVersion();
  }
}
