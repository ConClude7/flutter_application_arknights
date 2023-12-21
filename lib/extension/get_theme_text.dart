import 'package:flutter/material.dart';

class ThemeTest {
  static const String notoSerif = 'NotoSerif';
  static const String playFair = 'Playfair';
  static TextStyle displayLage(BuildContext context) =>
      Theme.of(context).textTheme.displayLarge!.copyWith(fontFamily: notoSerif);
  static TextStyle titleLarge(BuildContext context) =>
      Theme.of(context).textTheme.titleLarge!.copyWith(fontFamily: notoSerif);
  static TextStyle titleMedium(BuildContext context) =>
      Theme.of(context).textTheme.titleMedium!.copyWith(fontFamily: notoSerif);
  static TextStyle titleSmall(BuildContext context) =>
      Theme.of(context).textTheme.titleSmall!.copyWith(fontFamily: notoSerif);
  static TextStyle headlineLarge(BuildContext context) => Theme.of(context)
      .textTheme
      .headlineLarge!
      .copyWith(fontFamily: notoSerif);
  static TextStyle headlineMedium(BuildContext context) => Theme.of(context)
      .textTheme
      .headlineMedium!
      .copyWith(fontFamily: notoSerif);
  static TextStyle headlineSmall(BuildContext context) => Theme.of(context)
      .textTheme
      .headlineSmall!
      .copyWith(fontFamily: notoSerif);
  static TextStyle bodyLarge(BuildContext context) =>
      Theme.of(context).textTheme.bodyLarge!.copyWith(fontFamily: notoSerif);
  static TextStyle bodyMedium(BuildContext context) =>
      Theme.of(context).textTheme.bodyMedium!.copyWith(fontFamily: notoSerif);
  static TextStyle bodySmall(BuildContext context) =>
      Theme.of(context).textTheme.bodySmall!.copyWith(fontFamily: notoSerif);
  static TextStyle labelLarge(BuildContext context) =>
      Theme.of(context).textTheme.labelLarge!.copyWith(fontFamily: notoSerif);
  static TextStyle labelMedium(BuildContext context) =>
      Theme.of(context).textTheme.labelMedium!.copyWith(fontFamily: notoSerif);
  static TextStyle labelSmall(BuildContext context) =>
      Theme.of(context).textTheme.labelSmall!.copyWith(fontFamily: notoSerif);
}
