import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/base/base_stateless.dart';
import 'package:flutter_boilerplate/core/resources/app_assets.dart';
import 'package:flutter_boilerplate/core/theme/text_styles.dart';
import 'package:flutter_boilerplate/core/utils/media_query_utils.dart';
import 'package:flutter_boilerplate/widgets/buttons/outline_button.dart';
import 'package:flutter_boilerplate/widgets/custom_refresh_indicator.dart';
import 'package:flutter_svg/svg.dart';

class NoDataLayout extends BaseStatelessWidget {
  final String message;
  final bool parentHasAppBar;
  final VoidCallback? onPressed;
  final VoidCallback? onRefresh;

  const NoDataLayout({
    super.key,
    required this.message,
    this.parentHasAppBar = false,
    this.onPressed,
    this.onRefresh,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = getColorScheme(context);
    final localization = getLocalization(context);
    final isPortrait = MediaQueryUtils.isOrientationPortrait(context);
    Widget content = Container(
      padding: EdgeInsets.fromLTRB(
        16,
        0,
        16,
        parentHasAppBar ? kToolbarHeight : 16,
      ),
      color: colorScheme.surface,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 24),
            if (isPortrait)
              SvgPicture.asset(
                AppAssets.icons.noData(context),
                width: 128,
                height: 128,
                fit: BoxFit.cover,
              )
            else
              SizedBox(
                height: 64,
                child: SvgPicture.asset(
                  AppAssets.icons.noData(context),
                  width: 64,
                  height: 64,
                  fit: BoxFit.cover,
                ),
              ),
            Padding(
              padding: EdgeInsets.symmetric(
                vertical: isPortrait ? 24 : 8,
              ),
              child: Text(
                message,
                textAlign: TextAlign.center,
                style: TextStyles.semiBold(
                  color: colorScheme.onSurface,
                  fontSize: 18,
                ),
              ),
            ),
            if (onPressed != null)
              OutlineButton(
                width: 128,
                title: localization.try_again,
                onPressed: onPressed,
              ),
          ],
        ),
      ),
    );
    if (onRefresh == null) return content;
    return Stack(
      children: [
        content,
        Positioned.fill(
          child: CustomRefreshIndicator(
            onRefresh: () async {
              onRefresh?.call();
            },
            child: ListView(
              physics: const AlwaysScrollableScrollPhysics(),
              children: const [
                SizedBox(height: 1),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
