import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/core/base/base_stateless.dart';
import 'package:flutter_boilerplate/core/constants/app_dimensions.dart';
import 'package:flutter_boilerplate/features/feedback/domain/entities/user_feedback.dart';
import 'package:flutter_boilerplate/features/feedback/presentation/extensions/user_feedback_action_x.dart';

class FeedbackItem extends BaseStatelessWidget {
  final UserFeedback feedback;
  final VoidCallback? onPressed;

  const FeedbackItem({
    super.key,
    required this.feedback,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final borderRadius = AppDimensions.borderRadius;
    final colorScheme = getColorScheme(context);
    return InkWell(
      borderRadius: BorderRadius.circular(borderRadius),
      onTap: () => onPressed?.call(),
      child: Ink(
        decoration: BoxDecoration(
            color: feedback.isSelected
                ? colorScheme.onSurface
                : colorScheme.surfaceContainer,
            borderRadius: BorderRadius.circular(borderRadius)),
        child: Center(
          child: Text(
            feedback.action.title(context),
            textAlign: TextAlign.center,
            style: TextStyle(
                color: feedback.isSelected
                    ? colorScheme.surface
                    : colorScheme.surfaceContainerHighest,
                fontSize: 12,
                fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
