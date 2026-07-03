import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/features/languages/domain/entities/language.dart';
import 'package:flutter_boilerplate/l10n/app_localizations.dart';

extension LanguageActionX on LanguageAction {
  String title(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    switch (this) {
      case LanguageAction.english:
        return l10n.english;
      case LanguageAction.dutch:
        return l10n.dutch;
    }
  }
}
