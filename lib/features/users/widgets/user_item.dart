import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/base/base_stateless.dart';
import 'package:flutter_boilerplate/core/constants/app_dimensions.dart';
import 'package:flutter_boilerplate/features/users/models/user.dart';

class UserItem extends BaseStatelessWidget {
  final User user;
  final VoidCallback? onPressed;

  const UserItem({
    super.key,
    required this.user,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final borderRadius = AppDimensions.borderRadius;
    return Card(
      elevation: 0,
      margin: AppDimensions.verticalListItemMargin,
      child: InkWell(
        borderRadius: BorderRadius.circular(borderRadius),
        onTap: () => onPressed?.call(),
        child: ListTile(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(borderRadius)),
          key: Key(user.phone ?? ''),
          tileColor: getColorScheme(context).surfaceContainer,
          dense: true,
          leading: ClipRRect(
            borderRadius: BorderRadius.circular(AppDimensions.borderRadius),
            child: Image.network(user.picture?.large ?? ''),
          ),
          title: Text(
            '${user.name?.title} ${user.name?.first} ${user.name?.last}',
            style: const TextStyle(fontSize: 16),
          ),
          subtitle: Text(
            '${user.email}\n${user.phone}',
            style: const TextStyle(fontSize: 14),
          ),
        ),
      ),
    );
  }
}
