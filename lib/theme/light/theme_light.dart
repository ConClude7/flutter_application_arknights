import 'package:flutter/material.dart';
import 'package:flutter_application_arknights/theme/light/theme_color.dart';

ThemeData lightThemeData(BuildContext context) {
  final ColorScheme colorScheme = lightColorScheme(context);
  return ThemeData(useMaterial3: true, colorScheme: colorScheme);
}
