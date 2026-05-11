import 'dart:developer';
import 'package:package_info_plus/package_info_plus.dart';

class AppUtils {
  static Future<String> getAppName() async {
    try {
      final packageInfo = await PackageInfo.fromPlatform();
      return packageInfo.appName;
    } catch (error) {
      log('Could not get app name: ${error.toString()}');
      return '';
    }
  }

  static Future<String> getAppVersion() async {
    try {
      final packageInfo = await PackageInfo.fromPlatform();
      return packageInfo.version;
    } catch (error) {
      log('Could not get app version: ${error.toString()}');
      return '';
    }
  }
}
