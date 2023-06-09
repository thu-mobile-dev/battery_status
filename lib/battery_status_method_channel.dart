import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'battery_status_platform_interface.dart';

/// An implementation of [BatteryStatusPlatform] that uses method channels.
class MethodChannelBatteryStatus extends BatteryStatusPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('battery_status');

  @override
  Future<String?> getPlatformVersion() async {
    final version =
        await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }

  @override
  Future<bool?> isCharging() async {
    final isCharging = await methodChannel.invokeMethod<bool?>('isCharging');
    return isCharging;
  }

  @override
  Future<double?> value() async {
    final value = await methodChannel.invokeMethod<double?>('value');
    return value;
  }
}
