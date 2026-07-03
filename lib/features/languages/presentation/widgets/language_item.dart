import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/core/base/base_stateless.dart';
import 'package:flutter_boilerplate/features/languages/domain/entities/language.dart';
import 'package:flutter_boilerplate/features/languages/presentation/extensions/language_action_x.dart';

class LanguageItem extends BaseStatelessWidget {
  final Language language;
  final VoidCallback? onPressed;

  const LanguageItem({
    super.key,
    required this.language,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = getColorScheme(context);
    return ListTile(
      key: Key(language.action.title(context)),
      dense: true,
      title: Text(
        language.action.title(context),
        style: const TextStyle(fontSize: 14),
      ),
      trailing: language.selected
          ? const Icon(Icons.check_circle, size: 24)
          : const Icon(Icons.check_circle_outline, size: 24),
      contentPadding: const EdgeInsets.only(left: 16, right: 16),
      visualDensity: const VisualDensity(horizontal: -2, vertical: 2),
      iconColor: colorScheme.onSurface,
      textColor: colorScheme.onSurface,
      onTap: () => onPressed?.call(),
    );
  }
}
