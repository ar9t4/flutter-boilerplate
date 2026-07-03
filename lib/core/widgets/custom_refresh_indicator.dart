import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/core/base/base_stateless.dart';

class CustomRefreshIndicator extends BaseStatelessWidget {
  final RefreshCallback onRefresh;
  final Widget child;

  const CustomRefreshIndicator({
    super.key,
    required this.onRefresh,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = getColorScheme(context);
    return RefreshIndicator(
      color: colorScheme.onSurface,
      backgroundColor: colorScheme.surfaceContainer,
      onRefresh: onRefresh,
      child: child,
    );
  }
}
