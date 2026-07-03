import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/core/base/base_provider.dart';
import 'package:flutter_boilerplate/features/languages/presentation/extensions/language_action_x.dart';
import 'package:flutter_boilerplate/features/settings/domain/repositories/settings_repository.dart';
import 'package:flutter_boilerplate/features/themes/presentation/extensions/app_theme_mode_action_x.dart';
import 'package:flutter_boilerplate/l10n/app_localizations.dart';
import '../../../languages/domain/entities/language.dart';
import '../../domain/entities/settings.dart';
import '../../../themes/domain/entities/app_theme_mode.dart';

class SettingsProvider extends BaseProvider {
  final SettingsRepository repository;
  late ThemeMode _themeMode;
  late Locale _locale;
  var isLocaleUpdated = false;
  var settingsItems = <Settings>[];
  var themeItems = <AppThemeMode>[];
  var languageItems = <Language>[];

  SettingsProvider({required this.repository}) {
    _themeMode = _getThemeMode(getThemeSettings());
    _locale = _getLocale(getLanguageSettings());
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

  bool _getNotificationsSettings() => repository.getNotificationsSettings();

  void setNotificationsSettings(bool value) =>
      repository.setNotificationsSettings(value);

  String getThemeSettings() => repository.getThemeSettings();

  void setThemeSettings(String theme) => repository.setThemeSettings(theme);

  String getLanguageSettings() => repository.getLanguageSettings();

  void setLanguageSettings(String language) =>
      repository.setLanguageSettings(language);

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

  void fetchSettingsItems(BuildContext context, AppLocalizations l10n) {
    // fetch theme items
    final themes = _fetchThemeItems();
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
    final languages = _fetchLanguageItems();
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
        l10n.notifications,
        _getNotificationsSettings() ? true.toString() : false.toString(),
        const Icon(Icons.notifications)));
    settingsItems.add(Settings(2, l10n.theme, _getThemeName(context, themeCode),
        const Icon(Icons.dark_mode)));
    settingsItems.add(Settings(3, l10n.language,
        _getLanguageName(context, languageCode), const Icon(Icons.language)));
    isLocaleUpdated = false;
    notifyListeners();
  }

  List<AppThemeMode> _fetchThemeItems() => repository.fetchThemeItems();

  List<Language> _fetchLanguageItems() => repository.fetchLanguageItems();

  String _getThemeName(BuildContext context, String code) {
    return themeItems
        .firstWhere((element) => element.code == code)
        .action
        .title(context);
  }

  String _getLanguageName(BuildContext context, String locale) {
    return languageItems
        .firstWhere((element) => element.locale == locale)
        .action
        .title(context);
  }

  void toggleNotificationsSettings(AppLocalizations l10n) {
    bool notificationsSettings = _getNotificationsSettings();
    notificationsSettings = !notificationsSettings;
    // update notifications in preferences
    setNotificationsSettings(notificationsSettings);
    // update notifications in settings items
    int index = settingsItems
        .indexWhere((element) => element.key == l10n.notifications);
    if (index != -1) {
      var settingsItem = settingsItems[index];
      settingsItem.value =
          notificationsSettings ? true.toString() : false.toString();
      settingsItems[index] = settingsItem;
      notifyListeners();
    }
  }

  void updateDeviceThemeSettings(
    BuildContext context,
    AppLocalizations l10n,
    String themeCode,
  ) {
    // update theme in preferences
    setThemeSettings(themeCode);
    // update theme in settings items
    int index =
        settingsItems.indexWhere((element) => element.key == l10n.theme);
    if (index != -1) {
      var settingsItem = settingsItems[index];
      settingsItem.value = _getThemeName(context, themeCode);
      settingsItems[index] = settingsItem;
    }
    // update theme in theme items
    for (var element in themeItems) {
      element.selected = element.code == themeCode ? true : false;
    }
    // update app theme mode
    _setThemeMode(themeCode);
  }

  void updateDeviceLanguageSettings(String languageCode) {
    // update language in preferences
    setLanguageSettings(languageCode);
    // update app locale
    _setLocale(languageCode);
  }
}
