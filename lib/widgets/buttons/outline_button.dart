import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/base/base_stateless.dart';
import 'package:flutter_boilerplate/core/constants/app_dimensions.dart';
import 'package:flutter_boilerplate/core/theme/text_styles.dart';
import 'package:flutter_svg/svg.dart';

class OutlineButton extends BaseStatelessWidget {
  final double? width;
  final double height;
  final String? icon;
  final Size iconSize;
  final String title;
  final bool titleInCenter;
  final double fontSize;
  final Color? color;
  final bool withMinorPadding;
  final TextStyle? style;
  final bool isDisabled;
  final VoidCallback? onPressed;

  const OutlineButton({
    super.key,
    this.width,
    this.height = 40,
    this.icon,
    this.iconSize = const Size(18, 18),
    required this.title,
    this.titleInCenter = true,
    this.fontSize = 16,
    this.color,
    this.withMinorPadding = false,
    this.style,
    this.onPressed,
    this.isDisabled = false,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = getColorScheme(context);
    return SizedBox(
      width: width,
      height: height,
      child: OutlinedButton(
        onPressed: isDisabled ? null : onPressed,
        style: OutlinedButton.styleFrom(
          backgroundColor: colorScheme.surfaceContainer,
          side: BorderSide(
              color: isDisabled
                  ? (colorScheme.surfaceContainerHigh)
                  : (color ?? colorScheme.primary),
              width: 1),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppDimensions.borderRadius),
          ),
          padding: EdgeInsets.symmetric(horizontal: withMinorPadding ? 8 : 16),
        ),
        child: Row(
          mainAxisSize: titleInCenter ? MainAxisSize.min : MainAxisSize.max,
          mainAxisAlignment: titleInCenter
              ? MainAxisAlignment.center
              : MainAxisAlignment.start,
          spacing: 8,
          children: [
            if (icon != null) ...[
              SvgPicture.asset(
                icon ?? '',
                width: iconSize.width,
                height: iconSize.height,
                colorFilter: ColorFilter.mode(
                    isDisabled
                        ? (colorScheme.surfaceContainerHigh)
                        : (color ?? colorScheme.primary),
                    BlendMode.srcIn),
              ),
            ],
            Text(
              title,
              style: style ??
                  TextStyles.medium(
                    color: isDisabled
                        ? (colorScheme.surfaceContainerHigh)
                        : (color ?? colorScheme.primary),
                    fontSize: fontSize,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
