import 'package:flutter/material.dart';

enum AppFontFamily {
  montserrat('Montserrat');

  const AppFontFamily(this.value);
  final String value;
}

class TextStyles {
  static const AppFontFamily _defaultFontFamily = AppFontFamily.montserrat;

  static TextStyle thin({
    Color color = Colors.black,
    double fontSize = 16,
    AppFontFamily fontFamily = _defaultFontFamily,
    FontWeight fontWeight = FontWeight.w100,
  }) {
    return _buildTextStyle(
      fontWeight: fontWeight,
      fontSize: fontSize,
      color: color,
      fontFamily: fontFamily,
    );
  }

  static TextStyle extraLight({
    Color color = Colors.black,
    double fontSize = 16,
    AppFontFamily fontFamily = _defaultFontFamily,
    FontWeight fontWeight = FontWeight.w200,
  }) {
    return _buildTextStyle(
      fontWeight: fontWeight,
      fontSize: fontSize,
      color: color,
      fontFamily: fontFamily,
    );
  }

  static TextStyle light({
    Color color = Colors.black,
    double fontSize = 16,
    AppFontFamily fontFamily = _defaultFontFamily,
    FontWeight fontWeight = FontWeight.w300,
  }) {
    return _buildTextStyle(
      fontWeight: fontWeight,
      fontSize: fontSize,
      color: color,
      fontFamily: fontFamily,
    );
  }

  static TextStyle regular({
    Color color = Colors.black,
    double fontSize = 16,
    FontWeight fontWeight = FontWeight.w400,
    AppFontFamily fontFamily = _defaultFontFamily,
  }) {
    return _buildTextStyle(
      fontWeight: fontWeight,
      fontSize: fontSize,
      color: color,
      fontFamily: fontFamily,
    );
  }

  static TextStyle medium({
    Color color = Colors.black,
    double fontSize = 16,
    FontWeight fontWeight = FontWeight.w500,
    AppFontFamily fontFamily = _defaultFontFamily,
  }) {
    return _buildTextStyle(
      fontWeight: fontWeight,
      fontSize: fontSize,
      color: color,
      fontFamily: fontFamily,
    );
  }

  static TextStyle semiBold({
    Color color = Colors.black,
    double fontSize = 16,
    FontWeight fontWeight = FontWeight.w600,
    AppFontFamily fontFamily = _defaultFontFamily,
  }) {
    return _buildTextStyle(
      fontWeight: fontWeight,
      fontSize: fontSize,
      color: color,
      fontFamily: fontFamily,
    );
  }

  static TextStyle bold({
    Color color = Colors.black,
    double fontSize = 16,
    FontWeight fontWeight = FontWeight.w700,
    AppFontFamily fontFamily = _defaultFontFamily,
  }) {
    return _buildTextStyle(
      fontWeight: fontWeight,
      fontSize: fontSize,
      color: color,
      fontFamily: fontFamily,
    );
  }

  static TextStyle extraBold({
    Color color = Colors.black,
    double fontSize = 16,
    FontWeight fontWeight = FontWeight.w800,
    AppFontFamily fontFamily = _defaultFontFamily,
  }) {
    return _buildTextStyle(
      fontWeight: fontWeight,
      fontSize: fontSize,
      color: color,
      fontFamily: fontFamily,
    );
  }

  static TextStyle black({
    Color color = Colors.black,
    double fontSize = 16,
    FontWeight fontWeight = FontWeight.w900,
    AppFontFamily fontFamily = _defaultFontFamily,
  }) {
    return _buildTextStyle(
      fontWeight: fontWeight,
      fontSize: fontSize,
      color: color,
      fontFamily: fontFamily,
    );
  }

  static TextStyle _buildTextStyle({
    required FontWeight fontWeight,
    required double fontSize,
    required Color color,
    required AppFontFamily fontFamily,
  }) {
    return TextStyle(
      fontWeight: fontWeight,
      fontSize: fontSize,
      color: color,
      fontFamily: fontFamily.value,
    );
  }
}
