import 'package:flutter_boilerplate/features/languages/domain/entities/language.dart';
import 'package:flutter_boilerplate/features/themes/domain/entities/app_theme_mode.dart';

abstract interface class SettingsRepository {
  List<AppThemeMode> fetchThemeItems();
  List<Language> fetchLanguageItems();
  bool getNotificationsSettings();
  void setNotificationsSettings(bool value);
  String getThemeSettings();
  void setThemeSettings(String theme);
  String getLanguageSettings();
  void setLanguageSettings(String language);
}
