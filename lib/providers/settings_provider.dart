import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/providers/app_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../model/data/local/language_item.dart';
import '../model/data/local/setting_item.dart';
import '../model/data/local/theme_item.dart';

class SettingsProvider extends ChangeNotifier {
  late AppProvider _appProvider;
  late ThemeMode _themeMode;
  late Locale _locale;
  var isLocaleUpdated = false;
  var themeItems = <ThemeItem>[];
  var settingsItems = <SettingItem>[];
  var languageItems = <LanguageItem>[];

  SettingsProvider(BuildContext buildContext) {
    _appProvider = Provider.of<AppProvider>(buildContext, listen: false);
    _themeMode = _getThemeMode(_appProvider.getThemeSettings());
    _locale = _getLocale(_appProvider.getLanguageSettings());
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
    String themeCode = _appProvider.getThemeSettings();
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
    String languageCode = _appProvider.getLanguageSettings();
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
    settingsItems.add(SettingItem(
        1,
        appLocalizations.notifications,
        _appProvider.getNotificationsSettings()
            ? true.toString()
            : false.toString(),
        const Icon(Icons.notifications)));
    settingsItems.add(SettingItem(2, appLocalizations.theme,
        _getThemeName(themeCode), const Icon(Icons.dark_mode)));
    settingsItems.add(SettingItem(3, appLocalizations.language,
        _getLanguageName(languageCode), const Icon(Icons.language)));
    isLocaleUpdated = false;
    notifyListeners();
  }

  List<ThemeItem> _fetchThemeItems(AppLocalizations appLocalizations) {
    var themeItems = <ThemeItem>[];
    themeItems.add(ThemeItem(1, appLocalizations.auto, 'auto', false));
    themeItems.add(ThemeItem(2, appLocalizations.light_mode, 'light', false));
    themeItems.add(ThemeItem(3, appLocalizations.dark_mode, 'dark', false));
    return themeItems;
  }

  List<LanguageItem> _fetchLanguageItems(AppLocalizations appLocalizations) {
    var languageItems = <LanguageItem>[];
    languageItems.add(LanguageItem(1, appLocalizations.english, 'en', false));
    languageItems.add(LanguageItem(2, appLocalizations.dutch, 'nl', false));
    return languageItems;
  }

  String _getThemeName(String code) {
    return themeItems.firstWhere((element) => element.code == code).name;
  }

  String _getLanguageName(String locale) {
    return languageItems.firstWhere((element) => element.locale == locale).name;
  }

  void toggleNotificationsSettings(AppLocalizations appLocalizations) {
    bool notificationsSettings = _appProvider.getNotificationsSettings();
    notificationsSettings = !notificationsSettings;
    // update notifications in preferences
    _appProvider.setNotificationsSettings(notificationsSettings);
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
    _appProvider.setThemeSettings(themeCode);
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
      AppLocalizations appLocalizations, String languageCode) {
    // update language in preferences
    _appProvider.setLanguageSettings(languageCode);
    // update app locale
    _setLocale(languageCode);
  }
}
