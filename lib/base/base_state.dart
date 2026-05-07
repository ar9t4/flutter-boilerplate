import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/core/theme/app_colors_extension.dart';
import 'package:flutter_boilerplate/core/utils/media_query_utils.dart';
import 'package:flutter_boilerplate/l10n/app_localizations.dart';
import 'package:flutter_boilerplate/widgets/circular_progress_bar.dart';
import 'package:flutter_boilerplate/widgets/custom_alert_dialog.dart';
import 'package:flutter_boilerplate/remote/result.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';

abstract class BaseState<T extends StatefulWidget> extends State<T> {
  OverlayEntry? _loaderOverlay;
  late String route;
  late ColorScheme colorScheme;
  late AppColorsExtension appColors;
  late AppLocalizations localization;
  late bool isOrientationLandscape;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    isOrientationLandscape = MediaQueryUtils.isOrientationLandscape(context);
    try {
      route = GoRouterState.of(context).uri.toString();
    } catch (e) {
      route = '';
    }
    colorScheme = Theme.of(context).colorScheme;
    appColors = Theme.of(context).extension<AppColorsExtension>()!;
    localization = AppLocalizations.of(context);
  }

  void showToast(String message, {ToastGravity gravity = ToastGravity.BOTTOM}) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        timeInSecForIosWeb: 2,
        fontSize: 16,
        fontAsset: "assets/fonts/Montserrat-Medium.ttf",
        gravity: gravity,
        backgroundColor: colorScheme.primary,
        textColor: colorScheme.onPrimary);
  }

  void showLoaderOverlay() {
    if (_loaderOverlay != null) return;
    _loaderOverlay = OverlayEntry(
      builder: (_) => Stack(
        children: [
          ModalBarrier(
            dismissible: false,
            color: Color.fromRGBO(0, 0, 0, 0.5),
          ),
          const Center(
            child: CircularProgressBar(),
          ),
        ],
      ),
    );
    Overlay.of(context).insert(_loaderOverlay!);
  }

  void removeLoaderOverlay() {
    _loaderOverlay?.remove();
    _loaderOverlay = null;
  }

  void showErrorDialog(Error error) async {
    if (mounted) {
      final localization = AppLocalizations.of(context);
      showDialog(
        context: context,
        builder: (context) {
          return CustomAlertDialog(
            title: localization.error,
            message: error.message ?? '',
            positiveActionText: localization.ok,
            positiveAction: () => Navigator.of(context).pop(),
          );
        },
      );
    }
  }
}
