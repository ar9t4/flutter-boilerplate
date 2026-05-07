import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/core/theme/color_schemes.dart';
import 'app_colors_extension.dart';

class AppTheme {
  static final lightTheme = ThemeData(
    useMaterial3: true,
    colorScheme: lightColorScheme,
    extensions: [const AppColorsExtension(rating: Colors.orange)],
    textSelectionTheme: TextSelectionThemeData(
      cursorColor: lightColorScheme.onSurface,
    ),
    bottomSheetTheme: BottomSheetThemeData(
      showDragHandle: false,
      dragHandleColor: Colors.transparent,
      dragHandleSize: Size(0, 0),
    ),
    datePickerTheme: DatePickerThemeData(
      backgroundColor: lightColorScheme.surfaceContainer,
    ),
    checkboxTheme: CheckboxThemeData(
      side: BorderSide(
        color: lightColorScheme.surfaceContainerHighest,
        width: 1,
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(2)),
    ),
  );

  static final darkTheme = ThemeData(
    useMaterial3: true,
    colorScheme: darkColorScheme,
    extensions: [const AppColorsExtension(rating: Colors.orange)],
    textSelectionTheme: TextSelectionThemeData(
      cursorColor: darkColorScheme.onSurface,
    ),
    bottomSheetTheme: BottomSheetThemeData(
      showDragHandle: false,
      dragHandleColor: Colors.transparent,
      dragHandleSize: Size(0, 0),
    ),
    datePickerTheme: DatePickerThemeData(
      backgroundColor: darkColorScheme.surfaceContainer,
    ),
    checkboxTheme: CheckboxThemeData(
      side: BorderSide(
        color: darkColorScheme.surfaceContainerHighest,
        width: 1,
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(2)),
    ),
  );
}
