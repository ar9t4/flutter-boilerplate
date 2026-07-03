import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/features/themes/domain/entities/app_theme_mode.dart';
import 'package:flutter_boilerplate/l10n/app_localizations.dart';

extension AppThemeModeActionX on AppThemeModeAction {
  String title(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    switch (this) {
      case AppThemeModeAction.auto:
        return l10n.auto;
      case AppThemeModeAction.light:
        return l10n.light_mode;
      case AppThemeModeAction.dark:
        return l10n.dark_mode;
    }
  }
}
