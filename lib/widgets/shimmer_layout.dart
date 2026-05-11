import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/base/base_stateless.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

class ShimmerLayout extends BaseStatelessWidget {
  final double width;
  final double height;
  final double borderRadius;
  final Radius topLeft;
  final Radius topRight;
  final Radius bottomLeft;
  final Radius bottomRight;

  const ShimmerLayout({
    super.key,
    this.width = 100,
    this.height = 100,
    this.borderRadius = 4,
    this.topLeft = const Radius.circular(4),
    this.topRight = const Radius.circular(4),
    this.bottomLeft = const Radius.circular(4),
    this.bottomRight = const Radius.circular(4),
  });

  @override
  Widget build(BuildContext context) {
    ColorScheme colorScheme = getColorScheme(context);
    return ClipRRect(
      borderRadius: BorderRadius.only(
          topLeft: topLeft,
          bottomLeft: bottomLeft,
          topRight: topRight,
          bottomRight: bottomRight),
      child: Shimmer(
        duration: const Duration(seconds: 3),
        interval: const Duration(seconds: 0),
        color: colorScheme.surfaceContainerHighest,
        colorOpacity: 0.3,
        enabled: true,
        direction: const ShimmerDirection.fromLTRB(),
        child: Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            color: colorScheme.surfaceContainer,
            borderRadius: BorderRadius.only(
              topLeft: topLeft,
              bottomLeft: bottomLeft,
              topRight: topRight,
              bottomRight: bottomRight,
            ),
          ),
        ),
      ),
    );
  }
}
