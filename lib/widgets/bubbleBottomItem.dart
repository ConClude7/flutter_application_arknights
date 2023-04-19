import 'package:bubble_bottom_bar/bubble_bottom_bar.dart';
import 'package:flutter/cupertino.dart';

BubbleBottomBarItem BubbleItem(IconData icon, Color colorFalse, Color colorTrue,
    Color backgroundColor, String title) {
  return BubbleBottomBarItem(
      showBadge: false,
      backgroundColor: backgroundColor,
      icon: Icon(
        icon,
        color: colorFalse,
      ),
      activeIcon: Icon(
        icon,
        color: colorTrue,
      ),
      title: Opacity(
        opacity: .8,
        child: Text(
          title,
          style: TextStyle(color: colorTrue),
        ),
      ));
}
