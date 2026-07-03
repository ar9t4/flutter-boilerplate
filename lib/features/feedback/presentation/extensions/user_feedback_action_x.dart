import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/features/feedback/domain/entities/user_feedback.dart';
import 'package:flutter_boilerplate/l10n/app_localizations.dart';

extension UserFeedbackActionX on UserFeedbackAction {
  String title(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    switch (this) {
      case UserFeedbackAction.improveDesign:
        return l10n.improve_design;
      case UserFeedbackAction.improveExperience:
        return l10n.improve_experience;
      case UserFeedbackAction.improveFunctionality:
        return l10n.improve_functionality;
      case UserFeedbackAction.improvePerformance:
        return l10n.improve_performance;
    }
  }
}
