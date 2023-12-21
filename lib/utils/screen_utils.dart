import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// 方便更改第三方屏幕适配插件
class HHSize {
  /// 适配屏幕大小
  static Size screenSize = const Size(375, 812);

  static double appBarHeight = 44.toH;

  /// 屏幕宽度 .sw
  static double screenWidget = ScreenUtil().screenWidth;

  /// 屏幕高度 .sh
  static double screenHeight = ScreenUtil().scaleHeight;

  /// 底部安全区距离
  static double bottomBarHeight = ScreenUtil().bottomBarHeight;

  /// 状态栏高度
  static double statusBarHeight = ScreenUtil().statusBarHeight;

  /// 系统字体缩放比例
  static double textScale = ScreenUtil().textScaleFactor;

  /// 屏幕方向
  static Orientation orientation = ScreenUtil().orientation;
}

extension HHSizeExtension on num {
  /// 宽度
  double get toW => w;

  /// 高度
  double get toH => h;

  double get toSp => sp;

  /// 圆角
  double get toR => r;

  /// 屏幕宽
  double get toSw => sw;

  /// 屏幕高
  double get toSh => sh;
}
