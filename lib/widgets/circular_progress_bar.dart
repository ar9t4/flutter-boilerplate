import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/base/base_stateless.dart';

class CircularProgressBar extends BaseStatelessWidget {
  const CircularProgressBar({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = getColorScheme(context);
    return Container(
      width: 64,
      height: 64,
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainer,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Center(
        child: CircularProgressIndicator(
          backgroundColor: colorScheme.surfaceContainer,
          color: colorScheme.onSurface,
          strokeWidth: 4,
        ),
      ),
    );
  }
}
