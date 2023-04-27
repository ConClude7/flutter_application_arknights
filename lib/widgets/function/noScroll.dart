// ignore: file_names
import 'package:flutter/material.dart';

class NoScrollBehaviorWidget extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    switch (getPlatform(context)) {
      case TargetPlatform.iOS:
        return child;
      case TargetPlatform.android:
      case TargetPlatform.fuchsia:
        return GlowingOverscrollIndicator(
          axisDirection: axisDirection,
          color: Theme.of(context).colorScheme.secondary,
          showTrailing: false,
          showLeading: false,
          child: child,
        );
      case TargetPlatform.linux:
        break;
      case TargetPlatform.macOS:
        break;
      case TargetPlatform.windows:
        break;
    }
    return child;
  }
}
