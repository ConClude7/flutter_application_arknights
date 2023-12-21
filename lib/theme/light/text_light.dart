import 'package:flutter/material.dart';
import 'package:flutter_application_arknights/theme/light/color_light.dart';
import 'package:flutter_application_arknights/utils/screen_utils.dart';

TextTheme lightTextTheme(BuildContext context) {
  final Color textBlack = lightColorScheme.onSurface;
  final Color textGray = lightColorScheme.onSurfaceVariant;

  return TextTheme(
    displayLarge: TextStyle(
      fontSize: 32.toSp,
      fontWeight: FontWeight.bold,
      color: textBlack,
    ),
    titleLarge: TextStyle(
      fontSize: 28.toSp,
      fontWeight: FontWeight.bold,
      color: textBlack,
    ),
    titleMedium: TextStyle(
      fontSize: 24.toSp,
      fontWeight: FontWeight.bold,
      color: textBlack,
    ),
    titleSmall: TextStyle(
      fontSize: 18.toSp,
      fontWeight: FontWeight.normal,
      color: textBlack,
    ),
    headlineLarge: TextStyle(
      fontSize: 20.toSp,
      fontWeight: FontWeight.bold,
      color: textBlack,
    ),
    headlineMedium: TextStyle(
      fontSize: 17.toSp,
      fontWeight: FontWeight.normal,
      color: textBlack,
    ),
    headlineSmall: TextStyle(
      fontSize: 16.toSp,
      fontWeight: FontWeight.bold,
      color: textBlack,
    ),
    bodyLarge: TextStyle(
      fontSize: 17.toSp,
      fontWeight: FontWeight.normal,
      color: textBlack,
    ),
    bodyMedium: TextStyle(
      fontSize: 15.toSp,
      fontWeight: FontWeight.normal,
      color: textBlack,
    ),
    bodySmall: TextStyle(
      fontSize: 14.toSp,
      fontWeight: FontWeight.normal,
      color: textBlack,
    ),
    labelLarge: TextStyle(
      fontSize: 13.toSp,
      fontWeight: FontWeight.normal,
      color: textGray,
    ),
    labelMedium: TextStyle(
      fontSize: 12.toSp,
      fontWeight: FontWeight.normal,
      color: textGray,
    ),
    labelSmall: TextStyle(
      fontSize: 10.toSp,
      fontWeight: FontWeight.normal,
      color: textGray,
    ),
  );
}
