import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/core/base/base_stateless.dart';
import 'package:flutter_boilerplate/features/settings/domain/entities/settings.dart';

class SettingsItem extends BaseStatelessWidget {
  final Settings settings;
  final ValueChanged<bool> onChanged;
  final VoidCallback? onPressed;

  const SettingsItem({
    super.key,
    required this.settings,
    required this.onChanged,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final index = settings.id;
    final colorScheme = getColorScheme(context);
    final l10n = getLocalization(context);
    return ListTile(
      key: Key(settings.id.toString()),
      dense: true,
      leading: settings.icon,
      title: Text(settings.key, style: const TextStyle(fontSize: 14)),
      subtitle: Text(
          index == 1
              ? settings.value == true.toString()
                  ? l10n.on
                  : l10n.off
              : settings.value,
          style: const TextStyle(fontSize: 14)),
      trailing: index == 1
          ? Transform.scale(
              scale: 0.75,
              alignment: Alignment.centerRight,
              child: Switch(
                value: (settings.value == true.toString() ? true : false),
                onChanged: onChanged,
                thumbColor:
                    WidgetStateProperty.all(colorScheme.surfaceContainer),
                trackColor: WidgetStateProperty.all(
                    colorScheme.surfaceContainerHighest),
              ),
            )
          : const Icon(Icons.arrow_circle_right_outlined, size: 24),
      contentPadding: const EdgeInsets.only(left: 16, right: 16),
      visualDensity: const VisualDensity(horizontal: -2, vertical: 2),
      iconColor: colorScheme.onSurface,
      textColor: colorScheme.onSurface,
      onTap: () => onPressed?.call(),
    );
  }
}
