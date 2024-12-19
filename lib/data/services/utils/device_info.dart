import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';

Future<String?> getDeviceId() async {
  final deviceInfoPlugin = DeviceInfoPlugin();
  try {
    if (defaultTargetPlatform == TargetPlatform.android) {
      // Android
      AndroidDeviceInfo androidInfo = await deviceInfoPlugin.androidInfo;
      return androidInfo.id; // Use `androidId` for unique ID
    } else if (defaultTargetPlatform == TargetPlatform.iOS) {
      // iOS
      IosDeviceInfo iosInfo = await deviceInfoPlugin.iosInfo;
      return iosInfo.identifierForVendor; // Unique ID for iOS
    }
  } catch (e) {
    return null;
  }
}
