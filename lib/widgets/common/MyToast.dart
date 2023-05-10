import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:motion_toast/resources/arrays.dart';

// ignore: camel_case_types
class MyToast {
  static double width = 500.sp;
  static double height = 80.sp;
  static late Color toastColor;
  static TextStyle textStyle = const TextStyle(
      color: Color.fromARGB(255, 255, 255, 255), fontWeight: FontWeight.bold);
  static Color primaryColor = const Color.fromARGB(255, 80, 81, 79);

  static warning(BuildContext context, String text, String? title) {
    toastColor = const Color.fromARGB(255, 255, 224, 102);
    _toast(context, text, title ??= "");
  }

  static success(BuildContext context, String text, String? title) {
    toastColor = const Color.fromARGB(255, 112, 193, 179);
    _toast(context, text, title ??= "");
  }

  static error(BuildContext context, String text, String? title) {
    toastColor = const Color.fromARGB(255, 242, 95, 92);
    _toast(context, text, title ??= "");
  }

  static normal(BuildContext context, String text, String? title) {
    toastColor = const Color.fromARGB(255, 80, 81, 79);
    _toast(context, text, title ??= "");
  }

  // ignore: prefer_function_declarations_over_variables
  static final _toast = (BuildContext context, String text, String title) {
    return MotionToast(
      width: width,
      height: title == "" ? height : height + 20.sp,
      primaryColor: primaryColor,
      secondaryColor: toastColor,
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
  };
}
