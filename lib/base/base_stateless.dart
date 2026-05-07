import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/core/theme/app_colors_extension.dart';
import 'package:flutter_boilerplate/l10n/app_localizations.dart';
import 'package:fluttertoast/fluttertoast.dart';

abstract class BaseStatelessWidget extends StatelessWidget {
  const BaseStatelessWidget({super.key});

  ColorScheme getColorScheme(BuildContext context) {
    return Theme.of(context).colorScheme;
  }

  AppColorsExtension getAppColors(BuildContext context) {
    return Theme.of(context).extension<AppColorsExtension>()!;
  }

  bool isDarkMode(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark;
  }

  AppLocalizations getLocalization(BuildContext context) {
    return AppLocalizations.of(context);
  }

  void showToast(BuildContext context, String message,
      {ToastGravity gravity = ToastGravity.BOTTOM}) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        timeInSecForIosWeb: 2,
        fontSize: 16,
        fontAsset: "assets/fonts/Montserrat-Medium.ttf",
        gravity: gravity,
        backgroundColor: getColorScheme(context).primary,
        textColor: getColorScheme(context).onPrimary);
  }
}
