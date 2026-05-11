import 'package:flutter/material.dart';

class AppAssets {
  AppAssets._();

  static final icons = _AppIcons();
  static final images = _AppImages();
}

class _AppIcons {
  // no data | error
  String noData(BuildContext context) =>
      _iconForTheme(context, 'assets/icons/no_data_icon.svg');

  String error(BuildContext context) =>
      _iconForTheme(context, 'assets/icons/error_icon.svg');

  String _iconForTheme(BuildContext context, String path,
      {bool hasDark = false}) {
    final brightness = Theme.of(context).brightness;
    if (brightness == Brightness.dark && hasDark) {
      final darkPath = _generateDarkPath(path);
      return darkPath;
    }
    return path;
  }

  static String _generateDarkPath(String path) {
    final lastDotIndex = path.lastIndexOf('.');
    if (lastDotIndex == -1) {
      return '${path}_dark';
    }
    final pathWithoutExtension = path.substring(0, lastDotIndex);
    final extension = path.substring(lastDotIndex);
    return '${pathWithoutExtension}_dark$extension';
  }
}

class _AppImages {
  String feedback(BuildContext context) =>
      _imageForTheme(context, 'assets/images/feedback.webp');

  String _imageForTheme(BuildContext context, String path,
      {bool hasDark = false}) {
    final brightness = Theme.of(context).brightness;
    if (brightness == Brightness.dark && hasDark) {
      final darkPath = _generateDarkPath(path);
      return darkPath;
    }
    return path;
  }

  String _generateDarkPath(String path) {
    final lastDotIndex = path.lastIndexOf('.');
    if (lastDotIndex == -1) {
      return '${path}_dark';
    }
    final pathWithoutExtension = path.substring(0, lastDotIndex);
    final extension = path.substring(lastDotIndex);
    return '${pathWithoutExtension}_dark$extension';
  }
}
