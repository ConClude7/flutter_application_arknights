import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_arknights/widgets/common/MyToast.dart';

class HttpError {
  ///未知错误
  // ignore: constant_identifier_names
  static const String UNKNOWN = "UNKNOWN";

  ///解析错误
  ///// ignore: constant_identifier_names
  static const String PARSE_ERROR = "PARSE_ERROR";

  ///网络错误
  ///// ignore: constant_identifier_names
  static const String NETWORK_ERROR = "NETWORK_ERROR";

  ///协议错误
  ///// ignore: constant_identifier_names
  static const String HTTP_ERROR = "HTTP_ERROR";

  ///证书错误
  ///// ignore: constant_identifier_names
  static const String SSL_ERROR = "SSL_ERROR";

  ///连接超时
  ///// ignore: constant_identifier_names
  static const String CONNECT_TIMEOUT = "CONNECT_TIMEOUT";

  ///响应超时
  ///// ignore: constant_identifier_names
  static const String RECEIVE_TIMEOUT = "RECEIVE_TIMEOUT";

  ///发送超时
  ///// ignore: constant_identifier_names
  static const String SEND_TIMEOUT = "SEND_TIMEOUT";

  ///网络请求取消
  ///// ignore: constant_identifier_names
  static const String CANCEL = "CANCEL";

  static late String code;

  static late String message;

  static dioError(BuildContext context, DioError error) {
    switch (error.type) {
      case DioErrorType.connectionTimeout:
        code = CONNECT_TIMEOUT;
        message = "网络连接超时，请检查网络设置";
        break;
      case DioErrorType.receiveTimeout:
        code = RECEIVE_TIMEOUT;
        message = "服务器异常，请稍后重试！";
        break;
      case DioErrorType.sendTimeout:
        code = SEND_TIMEOUT;
        message = "网络连接超时，请检查网络设置";
        break;
      case DioErrorType.badResponse:
        code = HTTP_ERROR;
        message = "服务器异常，请稍后重试！";
        break;
      case DioErrorType.cancel:
        code = CANCEL;
        message = "请求已被取消，请重新请求";
        break;
      case DioErrorType.unknown:
        code = UNKNOWN;
        message = "网络异常，请稍后重试！";
        break;
      case DioErrorType.badCertificate:
        code = UNKNOWN;
        message = "网络异常，请稍后重试！";
        break;
      case DioErrorType.connectionError:
        code = UNKNOWN;
        message = "网络异常，请稍后重试！";
        break;
    }
    _showError(context);
  }

  static _showError(BuildContext context) {
    MyToast.error(context, message, code);
  }
}
