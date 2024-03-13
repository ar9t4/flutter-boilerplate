import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/storage/preferences.dart';
import 'package:package_info_plus/package_info_plus.dart';

class AppProvider extends ChangeNotifier {
  late String appName = '';
  late String appVersion = '';
  late Preferences _preferences;
  var bottomNavigationSelectedIndex = 0;

  AppProvider() {
    _preferences = Preferences();
    getAppName();
    getAppVersion();
  }

  void getAppName() async {
    try {
      PackageInfo packageInfo = await PackageInfo.fromPlatform();
      appName = packageInfo.appName;
      notifyListeners();
    } catch (error) {
      log('Could not get app name: ${error.toString()}');
    }
  }

  void getAppVersion() async {
    try {
      PackageInfo packageInfo = await PackageInfo.fromPlatform();
      appVersion = packageInfo.version;
      notifyListeners();
    } catch (error) {
      log('Could not get app version: ${error.toString()}');
    }
  }

  void onBottomNavigationItemSelected(int index) {
    if (index >= 0 && index <= 3) {
      bottomNavigationSelectedIndex = index;
      notifyListeners();
    }
  }

  bool getNotificationsSettings() {
    return _preferences.getBool(_preferences.notifications);
  }

  void setNotificationsSettings(bool value) {
    _preferences.setBool(_preferences.notifications, value);
  }

  String getThemeSettings() {
    return _preferences.getString(_preferences.theme);
  }

  void setThemeSettings(String theme) {
    _preferences.setString(_preferences.theme, theme);
  }

    String getLanguageSettings() {
    return _preferences.getString(_preferences.language);
  }

  void setLanguageSettings(String language) {
    _preferences.setString(_preferences.language, language);
  }
}
