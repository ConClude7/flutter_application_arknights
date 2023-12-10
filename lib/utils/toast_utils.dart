import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

/// toast
void showToast(String text, {int closeTime = 2, ToastPosition? toastPosition}) {
  ToastUtils.showToast(
      msg: text, closeTime: closeTime, toastPosition: toastPosition);
}

/// toast弹出位置
enum ToastPosition {
  top, //头部
  center, //中间
  bottom, //底部
}

class ToastUtils {
  //文字toast
  static showToast(
      {required String msg, int closeTime = 2, ToastPosition? toastPosition}) {
    ToastGravity? position = ToastGravity.CENTER;
    switch (toastPosition) {
      case ToastPosition.top:
        position = ToastGravity.TOP;
        break;
      case ToastPosition.center:
        position = ToastGravity.CENTER;
        break;
      case ToastPosition.bottom:
        position = ToastGravity.BOTTOM;
        break;
      default:
        break;
    }
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_SHORT,
        gravity: position,
        timeInSecForIosWeb: closeTime,
        backgroundColor: Colors.black,
        textColor: Colors.white,
        fontSize: 16);
  }
}
