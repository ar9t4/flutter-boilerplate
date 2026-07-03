import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/core/base/base_stateless.dart';

class LineDivider extends BaseStatelessWidget {
  final EdgeInsetsGeometry? padding;

  const LineDivider({
    super.key,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = getColorScheme(context);
    return Padding(
      padding: padding ?? EdgeInsets.zero,
      child: Divider(
        height: 0,
        thickness: 0,
        color: colorScheme.onSurface,
      ),
    );
  }
}
