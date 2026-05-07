import 'package:flutter/material.dart';

@immutable
class AppColorsExtension extends ThemeExtension<AppColorsExtension> {
  final Color rating;

  const AppColorsExtension({
    required this.rating,
  });

  @override
  AppColorsExtension copyWith({Color? rating}) {
    return AppColorsExtension(rating: rating ?? this.rating);
  }

  @override
  AppColorsExtension lerp(ThemeExtension<AppColorsExtension>? other, double t) {
    if (other is! AppColorsExtension) {
      return this;
    }
    return AppColorsExtension(rating: Color.lerp(rating, other.rating, t)!);
  }
}
