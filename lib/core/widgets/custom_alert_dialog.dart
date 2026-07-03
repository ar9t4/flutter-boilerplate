import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/core/base/base_stateless.dart';
import 'package:flutter_boilerplate/core/theme/text_styles.dart';

class CustomAlertDialog extends BaseStatelessWidget {
  final String title;
  final String message;
  final String? negativeActionText;
  final VoidCallback? negativeAction;
  final String? positiveActionText;
  final Color? positiveActionColor;
  final VoidCallback? positiveAction;

  const CustomAlertDialog({
    super.key,
    required this.title,
    required this.message,
    this.negativeActionText,
    this.negativeAction,
    this.positiveActionText,
    this.positiveActionColor,
    this.positiveAction,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = getColorScheme(context);
    return AlertDialog(
      title: Text(
        title,
        style: TextStyles.semiBold(color: colorScheme.onSurface),
      ),
      content: Text(
        message,
        style: TextStyles.regular(color: colorScheme.onSurface, fontSize: 14),
      ),
      actions: [
        if (negativeActionText != null) ...[
          TextButton(
            onPressed: negativeAction,
            child: Text(
              negativeActionText ?? '',
              style: TextStyles.regular(
                color: colorScheme.onSurface,
                fontSize: 14,
              ),
            ),
          ),
        ],
        if (positiveActionText != null) ...[
          TextButton(
            onPressed: positiveAction,
            child: Text(
              positiveActionText ?? '',
              style: TextStyles.semiBold(
                color: positiveActionColor ?? colorScheme.primary,
                fontSize: 14,
              ),
            ),
          ),
        ]
      ],
      backgroundColor: colorScheme.surface,
    );
  }
}
