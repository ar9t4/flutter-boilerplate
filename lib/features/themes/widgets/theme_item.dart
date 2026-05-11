import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/base/base_stateless.dart';
import 'package:flutter_boilerplate/features/themes/models/app_theme_mode.dart';

class ThemeItem extends BaseStatelessWidget {
  final AppThemeMode theme;
  final VoidCallback? onPressed;

  const ThemeItem({
    super.key,
    required this.theme,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = getColorScheme(context);
    return ListTile(
      key: Key(theme.id.toString()),
      dense: true,
      title: Text(theme.name, style: const TextStyle(fontSize: 14)),
      trailing: theme.selected
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
