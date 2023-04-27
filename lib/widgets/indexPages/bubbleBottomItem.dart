import 'package:bubble_bottom_bar/bubble_bottom_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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

// 底部栏
List<BubbleBottomBarItem> bottomBarItems() {
  return [
    BubbleItem(
        Icons.houseboat_rounded,
        const Color.fromARGB(255, 229, 229, 229),
        const Color.fromARGB(255, 252, 163, 17),
        const Color.fromARGB(255, 67, 127, 151),
        "首页"),
    BubbleItem(
        Icons.directions_boat,
        const Color.fromARGB(255, 229, 229, 229),
        const Color.fromARGB(255, 252, 163, 17),
        const Color.fromARGB(255, 67, 127, 151),
        "模拟"),
    BubbleItem(
        Icons.water,
        const Color.fromARGB(255, 229, 229, 229),
        const Color.fromARGB(255, 252, 163, 17),
        const Color.fromARGB(255, 67, 127, 151),
        "收藏"),
    BubbleItem(
        Icons.surfing,
        const Color.fromARGB(255, 229, 229, 229),
        const Color.fromARGB(255, 252, 163, 17),
        const Color.fromARGB(255, 67, 127, 151),
        "个人档案"),
  ];
}

BubbleBottomBar bottomBar(currentIndex, changePage) {
  return BubbleBottomBar(
      backgroundColor: const Color.fromARGB(255, 20, 33, 61),
      hasNotch: true,
      opacity: .2,
      currentIndex: currentIndex,
      onTap: changePage,
      elevation: 2,
      tilesPadding: EdgeInsets.symmetric(
        vertical: 8.sp,
      ),
      items: bottomBarItems());
}
