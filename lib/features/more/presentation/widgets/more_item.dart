import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/core/base/base_stateless.dart';
import 'package:flutter_boilerplate/core/utils/app_utils.dart';
import 'package:flutter_boilerplate/features/more/domain/entities/more.dart';
import 'package:flutter_boilerplate/features/more/presentation/extensions/more_action_x.dart';

class MoreItem extends BaseStatelessWidget {
  final More more;
  final VoidCallback? onPressed;

  const MoreItem({
    super.key,
    required this.more,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = getColorScheme(context);
    final l10n = getLocalization(context);
    return ListTile(
      key: Key(more.action.title(context)),
      dense: true,
      leading: more.icon,
      title: Text(more.action.title(context),
          style: const TextStyle(fontSize: 14)),
      trailing: more.action.title(context) == l10n.version
          ? _buildVersion()
          : const Icon(Icons.arrow_circle_right_outlined, size: 24),
      contentPadding: const EdgeInsets.only(left: 16, right: 16),
      visualDensity: const VisualDensity(horizontal: -2, vertical: 3),
      iconColor: colorScheme.onSurface,
      textColor: colorScheme.onSurface,
      onTap: () => onPressed?.call(),
    );
  }

  Widget _buildVersion() {
    return FutureBuilder<String>(
      future: AppUtils.getAppVersion(),
      builder: (context, snapshot) {
        return Text(
          snapshot.data ?? '',
          style: const TextStyle(fontSize: 12),
        );
      },
    );
  }
}
