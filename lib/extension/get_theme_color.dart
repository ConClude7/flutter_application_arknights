import 'package:flutter/material.dart';

class ThemeColor {
  /// 1
  static Color primary(BuildContext context) =>
      Theme.of(context).colorScheme.primary;

  static Color onPrimary(BuildContext context) =>
      Theme.of(context).colorScheme.onPrimary;

  static Color primaryContainer(BuildContext context) =>
      Theme.of(context).colorScheme.primaryContainer;

  static Color onPrimaryContainer(BuildContext context) =>
      Theme.of(context).colorScheme.onPrimaryContainer;

  /// 2
  static Color secondary(BuildContext context) =>
      Theme.of(context).colorScheme.secondary;

  static Color onSecondary(BuildContext context) =>
      Theme.of(context).colorScheme.onSecondary;

  static Color secondaryContainer(BuildContext context) =>
      Theme.of(context).colorScheme.secondaryContainer;

  static Color onSecondaryContainer(BuildContext context) =>
      Theme.of(context).colorScheme.onSecondaryContainer;

  /// 3
  static Color tertiary(BuildContext context) =>
      Theme.of(context).colorScheme.tertiary;

  static Color onTertiary(BuildContext context) =>
      Theme.of(context).colorScheme.onTertiary;

  static Color tertiaryContainer(BuildContext context) =>
      Theme.of(context).colorScheme.tertiaryContainer;

  static Color onTertiaryContainer(BuildContext context) =>
      Theme.of(context).colorScheme.onTertiaryContainer;

  /// Error
  static Color error(BuildContext context) =>
      Theme.of(context).colorScheme.error;

  static Color onError(BuildContext context) =>
      Theme.of(context).colorScheme.onError;

  static Color errorContainer(BuildContext context) =>
      Theme.of(context).colorScheme.errorContainer;

  static Color onErrorContainer(BuildContext context) =>
      Theme.of(context).colorScheme.onErrorContainer;

  /// Text
  static Color surface(BuildContext context) =>
      Theme.of(context).colorScheme.surface;

  static Color onSurface(BuildContext context) =>
      Theme.of(context).colorScheme.onSurface;

  static Color surfaceVariant(BuildContext context) =>
      Theme.of(context).colorScheme.surfaceVariant;

  static Color onSurfaceVariant(BuildContext context) =>
      Theme.of(context).colorScheme.onSurfaceVariant;

  static Color surfaceTint(BuildContext context) =>
      Theme.of(context).colorScheme.surfaceTint;

  /// Line
  static Color outline(BuildContext context) =>
      Theme.of(context).colorScheme.outline;

  static Color outlineVariant(BuildContext context) =>
      Theme.of(context).colorScheme.outlineVariant;

  /// 反着的Text
  static Color inverseSurface(BuildContext context) =>
      Theme.of(context).colorScheme.inverseSurface;

  static Color onInverseSurface(BuildContext context) =>
      Theme.of(context).colorScheme.onInverseSurface;

  static Color inversePrimary(BuildContext context) =>
      Theme.of(context).colorScheme.inversePrimary;

  /// Bcakground
  static Color background(BuildContext context) =>
      Theme.of(context).colorScheme.background;

  static Color onBackground(BuildContext context) =>
      Theme.of(context).colorScheme.onBackground;

  static Color scrim(BuildContext context) =>
      Theme.of(context).colorScheme.scrim;

  static Color shadow(BuildContext context) =>
      Theme.of(context).colorScheme.shadow;
}
