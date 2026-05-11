import 'package:flutter/widgets.dart';
import 'package:flutter_boilerplate/base/base_stateless.dart';
import 'package:flutter_boilerplate/core/constants/app_dimensions.dart';

class SurfaceContainer extends BaseStatelessWidget {
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;
  final Color? bgColor;
  final Color? borderColor;
  final double? borderWidth;
  final Widget child;
  final double? radius;

  const SurfaceContainer({
    super.key,
    this.margin,
    this.padding,
    this.bgColor,
    this.borderColor,
    this.borderWidth,
    required this.child,
    this.radius,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = getColorScheme(context);
    return Container(
      width: double.infinity,
      padding: padding,
      decoration: BoxDecoration(
        color: bgColor ?? colorScheme.surfaceContainer,
        border: BoxBorder.all(
          color: borderColor ?? colorScheme.surfaceContainerHigh,
          width: borderWidth ?? 1,
        ),
        borderRadius:
            BorderRadius.circular(radius ?? AppDimensions.borderRadius),
      ),
      margin: margin,
      child: child,
    );
  }
}
