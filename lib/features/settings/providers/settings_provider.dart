import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/storage/preferences.dart';
import 'package:flutter_boilerplate/l10n/app_localizations.dart';
import '../../languages/models/language.dart';
import '../models/settings.dart';
import '../../themes/models/app_theme_mode.dart';

class SettingsProvider extends ChangeNotifier {
  late ThemeMode _themeMode;
  late Locale _locale;
  late Preferences _preferences;
  var isLocaleUpdated = false;
  var themeItems = <AppThemeMode>[];
  var settingsItems = <Settings>[];
  var languageItems = <Language>[];

  SettingsProvider(BuildContext buildContext) {
    _preferences = Preferences();
    _themeMode = _getThemeMode(getThemeSettings());
    _locale = _getLocale(getLanguageSettings());
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

  ThemeMode _getThemeMode(String themeCode) {
    if (themeCode == 'light') {
      return ThemeMode.light;
    } else if (themeCode == 'dark') {
      return ThemeMode.dark;
    } else {
      return ThemeMode.system;
    }
  }

  Locale _getLocale(String languageCode) {
    if (languageCode == 'en') {
      return const Locale('en');
    } else {
      return const Locale('nl');
    }
  }

  ThemeMode get themeMode => _themeMode;
  void _setThemeMode(String themeCode) {
    _themeMode = _getThemeMode(themeCode);
    notifyListeners();
  }

  Locale get locale => _locale;
  void _setLocale(String languageCode) {
    isLocaleUpdated = true;
    _locale = _getLocale(languageCode);
    notifyListeners();
  }

  void fetchSettingsItems(AppLocalizations appLocalizations) {
    // fetch theme items
    final themes = _fetchThemeItems(appLocalizations);
    // clear previous theme items
    themeItems.clear();
    themeItems.addAll(themes);
    // find and mark selected theme
    String themeCode = getThemeSettings();
    int themeIndex = themeItems.indexWhere((e) => e.code == themeCode);
    if (themeIndex != -1) {
      themeItems[themeIndex].selected = true;
    }
    // update theme mode
    _themeMode = _getThemeMode(themeCode);

    // fetch language items
    final languages = _fetchLanguageItems(appLocalizations);
    // clear previous language items
    languageItems.clear();
    languageItems.addAll(languages);
    // find and mark selected language
    String languageCode = getLanguageSettings();
    int languageIndex =
        languageItems.indexWhere((e) => e.locale == languageCode);
    if (languageIndex != -1) {
      languageItems[languageIndex].selected = true;
    }
    // update app locale
    _locale = _getLocale(languageCode);

    // clear previous settings items
    settingsItems.clear();
    // fetch settings items
    settingsItems.add(Settings(
        1,
        appLocalizations.notifications,
        getNotificationsSettings() ? true.toString() : false.toString(),
        const Icon(Icons.notifications)));
    settingsItems.add(Settings(2, appLocalizations.theme,
        _getThemeName(themeCode), const Icon(Icons.dark_mode)));
    settingsItems.add(Settings(3, appLocalizations.language,
        _getLanguageName(languageCode), const Icon(Icons.language)));
    isLocaleUpdated = false;
    notifyListeners();
  }

  List<AppThemeMode> _fetchThemeItems(AppLocalizations appLocalizations) {
    var themeItems = <AppThemeMode>[];
    themeItems.add(AppThemeMode(1, appLocalizations.auto, 'auto', false));
    themeItems
        .add(AppThemeMode(2, appLocalizations.light_mode, 'light', false));
    themeItems.add(AppThemeMode(3, appLocalizations.dark_mode, 'dark', false));
    return themeItems;
  }

  List<Language> _fetchLanguageItems(AppLocalizations appLocalizations) {
    var languageItems = <Language>[];
    languageItems.add(Language(1, appLocalizations.english, 'en', false));
    languageItems.add(Language(2, appLocalizations.dutch, 'nl', false));
    return languageItems;
  }

  String _getThemeName(String code) {
    return themeItems.firstWhere((element) => element.code == code).name;
  }

  String _getLanguageName(String locale) {
    return languageItems.firstWhere((element) => element.locale == locale).name;
  }

  void toggleNotificationsSettings(AppLocalizations appLocalizations) {
    bool notificationsSettings = getNotificationsSettings();
    notificationsSettings = !notificationsSettings;
    // update notifications in preferences
    setNotificationsSettings(notificationsSettings);
    // update notifications in settings items
    int index = settingsItems
        .indexWhere((element) => element.key == appLocalizations.notifications);
    if (index != -1) {
      var settingsItem = settingsItems[index];
      settingsItem.value =
          notificationsSettings ? true.toString() : false.toString();
      settingsItems[index] = settingsItem;
      notifyListeners();
    }
  }

  void updateDeviceThemeSettings(
      AppLocalizations appLocalizations, String themeCode) {
    // update theme in preferences
    setThemeSettings(themeCode);
    // update theme in settings items
    int index = settingsItems
        .indexWhere((element) => element.key == appLocalizations.theme);
    if (index != -1) {
      var settingsItem = settingsItems[index];
      settingsItem.value = _getThemeName(themeCode);
      settingsItems[index] = settingsItem;
    }
    // update theme in theme items
    for (var element in themeItems) {
      element.selected = element.code == themeCode ? true : false;
    }
    // update app theme mode
    _setThemeMode(themeCode);
  }

  void updateDeviceLanguageSettings(
      AppLocalizations localization, String languageCode) {
    // update language in preferences
    setLanguageSettings(languageCode);
    // update app locale
    _setLocale(languageCode);
  }
}
