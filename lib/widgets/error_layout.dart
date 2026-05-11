import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/base/base_stateless.dart';
import 'package:flutter_boilerplate/core/resources/app_assets.dart';
import 'package:flutter_boilerplate/core/theme/text_styles.dart';
import 'package:flutter_boilerplate/core/utils/media_query_utils.dart';
import 'package:flutter_boilerplate/widgets/buttons/outline_button.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_boilerplate/remote/result.dart';

class ErrorLayout extends BaseStatelessWidget {
  final Error? error;
  final String? errorMessage;
  final String? buttonLabel;
  final bool parentHasAppBar;
  final VoidCallback? onPressed;

  const ErrorLayout({
    super.key,
    this.error,
    this.errorMessage,
    this.buttonLabel,
    this.parentHasAppBar = false,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = getColorScheme(context);
    final localization = getLocalization(context);
    final isPortrait = MediaQueryUtils.isOrientationPortrait(context);
    return Container(
      padding:
          EdgeInsets.fromLTRB(16, 0, 16, parentHasAppBar ? kToolbarHeight : 16),
      color: colorScheme.surface,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 24),
            if (isPortrait) ...[
              SvgPicture.asset(
                AppAssets.icons.error(context),
                width: 128,
                height: 128,
                fit: BoxFit.cover,
              ),
            ] else ...[
              Flexible(
                child: SvgPicture.asset(
                  AppAssets.icons.error(context),
                  width: 64,
                  height: 64,
                  fit: BoxFit.cover,
                ),
              ),
            ],
            Padding(
              padding: EdgeInsets.symmetric(vertical: isPortrait ? 24 : 8),
              child: Text(
                errorMessage ?? error?.message ?? '',
                textAlign: TextAlign.center,
                style: TextStyles.semiBold(
                  color: colorScheme.onSurface,
                  fontSize: 18,
                ),
              ),
            ),
            OutlineButton(
              title: buttonLabel ?? localization.try_again,
              onPressed: () => onPressed?.call(),
            ),
          ],
        ),
      ),
    );
  }
}
