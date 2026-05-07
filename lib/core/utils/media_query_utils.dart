import 'package:flutter/material.dart';

class MediaQueryUtils {
  static double getWidth(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  static double getHeight(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }

  static Size getScreenSize(BuildContext context) {
    return MediaQuery.of(context).size;
  }

  static double getStatusBarHeight(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return mediaQuery.padding.top;
  }

  static double getBottomNavBarHeight(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return mediaQuery.padding.bottom;
  }

  static double getSafeAreaHeight(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final height = mediaQuery.size.height;
    final safePadding = mediaQuery.padding.top + mediaQuery.padding.bottom;
    return height - safePadding;
  }

  static bool isOrientationPortrait(BuildContext context) {
    return MediaQuery.of(context).orientation == Orientation.portrait;
  }

  static bool isOrientationLandscape(BuildContext context) {
    return MediaQuery.of(context).orientation == Orientation.landscape;
  }

  static Orientation getOrientation(BuildContext context) {
    return MediaQuery.of(context).orientation;
  }
}
