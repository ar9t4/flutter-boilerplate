import 'package:flutter_boilerplate/features/languages/domain/entities/language.dart';
import 'package:flutter_boilerplate/features/settings/domain/repositories/settings_repository.dart';
import 'package:flutter_boilerplate/features/themes/domain/entities/app_theme_mode.dart';
import 'package:flutter_boilerplate/core/storage/preferences.dart';

class SettingsRepositoryImpl implements SettingsRepository {
  final Preferences preferences;

  SettingsRepositoryImpl({required this.preferences});

  @override
  List<AppThemeMode> fetchThemeItems() {
    return [
      AppThemeMode(AppThemeModeAction.auto, 'auto', false),
      AppThemeMode(AppThemeModeAction.light, 'light', false),
      AppThemeMode(AppThemeModeAction.dark, 'dark', false),
    ];
  }

  @override
  List<Language> fetchLanguageItems() {
    return [
      Language(LanguageAction.english, 'en', false),
      Language(LanguageAction.dutch, 'nl', false),
    ];
  }

  @override
  bool getNotificationsSettings() {
    return preferences.getBool(preferences.notifications);
  }

  @override
  void setNotificationsSettings(bool value) {
    preferences.setBool(preferences.notifications, value);
  }

  @override
  String getThemeSettings() {
    return preferences.getString(preferences.theme);
  }

  @override
  void setThemeSettings(String theme) {
    preferences.setString(preferences.theme, theme);
  }

  @override
  String getLanguageSettings() {
    return preferences.getString(preferences.language);
  }

  @override
  void setLanguageSettings(String language) {
    preferences.setString(preferences.language, language);
  }
}
