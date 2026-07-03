import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/features/more/domain/entities/more.dart';
import 'package:flutter_boilerplate/l10n/app_localizations.dart';

extension MoreActionX on MoreAction {
  String title(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    switch (this) {
      case MoreAction.settings:
        return l10n.settings;
      case MoreAction.feedback:
        return l10n.feedback;
      case MoreAction.privacyPolicy:
        return l10n.privacy_policy;
      case MoreAction.share:
        return l10n.share;
      case MoreAction.rateUs:
        return l10n.rate_us;
      case MoreAction.moreApps:
        return l10n.more_apps;
      case MoreAction.version:
        return l10n.version;
    }
  }
}
