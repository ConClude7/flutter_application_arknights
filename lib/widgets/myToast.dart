import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:motion_toast/resources/arrays.dart';

// ignore: camel_case_types
class myToast {
  static double width = 250.sp;
  static double height = 40.sp;
  static TextStyle textStyle = const TextStyle(
      color: Color.fromARGB(255, 255, 255, 255), fontWeight: FontWeight.bold);
  static Color primaryColor = const Color.fromARGB(255, 80, 81, 79);

  static warning(BuildContext context, String text, String? title) {
    title ??= "";
    return MotionToast(
      width: width,
      height: title == "" ? height : height + 20.sp,
      primaryColor: primaryColor,
      secondaryColor: const Color.fromARGB(255, 255, 224, 102),
      backgroundType: BackgroundType.solid,
      animationType: AnimationType.fromLeft,
      position: MotionToastPosition.top,
      animationCurve: Curves.easeOutBack,
      borderRadius: 4.sp,
      description: Text(text, style: textStyle),
      title: title == ""
          ? null
          : Text(
              title,
              style: textStyle,
            ),
    ).show(context);
  }

  static success(BuildContext context, String text, String? title) {
    title ??= "";
    return MotionToast(
      width: width,
      height: title == "" ? height : height + 20.sp,
      primaryColor: primaryColor,
      secondaryColor: const Color.fromARGB(255, 112, 193, 179),
      backgroundType: BackgroundType.solid,
      animationType: AnimationType.fromLeft,
      position: MotionToastPosition.top,
      animationCurve: Curves.easeOutBack,
      borderRadius: 4.sp,
      description: Text(text, style: textStyle),
      title: title == ""
          ? null
          : Text(
              title,
              style: textStyle,
            ),
    ).show(context);
  }
}
