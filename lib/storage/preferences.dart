import 'dart:developer';
import 'package:shared_preferences/shared_preferences.dart';

class Preferences {
  final String hasDefaults = 'hasDefaults';
  final String notifications = 'notifications';
  final String theme = 'theme';
  final String language = 'language';

  late SharedPreferences sharedPreferences;
  static final Preferences _instance = Preferences._internal();

  factory Preferences() {
    return _instance;
  }

  Preferences._internal();

  Future<void> init() async {
    try {
      sharedPreferences = await SharedPreferences.getInstance();
      // setting default preferences
      if (!sharedPreferences.containsKey(hasDefaults)) {
        sharedPreferences.setBool(notifications, true);
        sharedPreferences.setString(theme, 'auto');
        sharedPreferences.setString(language, 'en');
        sharedPreferences.setBool(hasDefaults, true);
      }
    } catch (error) {
      log('Coult not initialize SharedPreferences: $error');
    }
  }

  void setInt(String key, int value) {
    sharedPreferences.setInt(key, value);
  }

  int getInt(String key) {
    return sharedPreferences.getInt(key) ?? -1;
  }

  void setDouble(String key, double value) {
    sharedPreferences.setDouble(key, value);
  }

  double getDouble(String key) {
    return sharedPreferences.getDouble(key) ?? -1;
  }

  void setBool(String key, bool value) {
    SharedPreferences.getInstance().then((preferences) {
      sharedPreferences = preferences;
      sharedPreferences.setBool(key, value);
    }).catchError((onError) {});
  }

  bool getBool(String key) {
    return sharedPreferences.getBool(key) ?? false;
  }

  void setString(String key, String value) {
    sharedPreferences.setString(key, value);
  }

  String getString(String key) {
    return sharedPreferences.getString(key) ?? '';
  }
}
