class AppThemeMode {
  AppThemeModeAction action;
  String code;
  bool selected;

  AppThemeMode(this.action, this.code, this.selected);
}

enum AppThemeModeAction { auto, light, dark }
