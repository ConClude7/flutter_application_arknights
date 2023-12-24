import 'package:dio/dio.dart';

class HttpError {
  String? code;
  String? message;
  Map<String, dynamic>? response;
  HttpErrorType type = HttpErrorType.other;

  HttpError(this.code, this.message, {this.response});

  HttpError.type(this.type, {this.response})
      : code = type.code,
        message = type.message;

  HttpError.dioError(DioExceptionType error) {
    switch (error) {
      case DioExceptionType.connectionTimeout:
        type = HttpErrorType.connectionTimeout;
        break;
      case DioExceptionType.sendTimeout:
        type = HttpErrorType.sendTimeout;
        break;
      case DioExceptionType.receiveTimeout:
        type = HttpErrorType.receiveTimeout;
        break;
      case DioExceptionType.badResponse:
        type = HttpErrorType.badResponse;
        break;
      case DioExceptionType.cancel:
        type = HttpErrorType.cancel;
        break;
      case DioExceptionType.unknown:
        type = HttpErrorType.unknown;
        break;
      case DioExceptionType.badCertificate:
      // TODO: Handle this case.
      case DioExceptionType.connectionError:
      // TODO: Handle this case.
    }
    code = type.code;
    message = type.message;
  }

  @override
  String toString() {
    return 'HttpError{code: $code, message: $message}';
  }
}

enum HttpErrorType {
  /// 其他错误 不展示图标和刷新按钮
  other,

  /// 后端业务类型的错误 不展示图标和刷新按钮
  business,

  /// 登录过期
  tokenExpired,

  /// 未知类型的请求错误
  unknown,

  /// 网络错误
  network,

  /// 连接超时
  connectionTimeout,

  /// 发送超时
  sendTimeout,

  /// 响应超时
  receiveTimeout,

  /// 服务器错误 404 500
  badResponse,

  /// 请求取消
  cancel,
}

extension HttpErrorTypeExtension on HttpErrorType {
  bool get isNormalError =>
      this == HttpErrorType.other || this == HttpErrorType.business;

  bool get isNetworkError =>
      this == HttpErrorType.unknown ||
      this == HttpErrorType.network ||
      this == HttpErrorType.connectionTimeout ||
      this == HttpErrorType.sendTimeout;

  String get code => _codeMap[this];

  String get message => _messageMap[this];
}

final Map _codeMap = {
  HttpErrorType.other: "OTHER",
  HttpErrorType.business: "BUSINESS",
  HttpErrorType.tokenExpired: "TOKEN_EXPIRED",
  HttpErrorType.unknown: "REQUEST_UNKNOW",
  HttpErrorType.network: "NETWORK_ERROR",
  HttpErrorType.connectionTimeout: "CONNECT_TIMEOUT",
  HttpErrorType.sendTimeout: "SEND_TIMEOUT",
  HttpErrorType.receiveTimeout: "RECEIVE_TIMEOUT",
  HttpErrorType.badResponse: "SERVER_ERROR",
  HttpErrorType.cancel: "CANCEL",
};

final Map _messageMap = {
  HttpErrorType.other: "发生错误，请稍后重试",
  HttpErrorType.business: "发生错误，请稍后重试",
  HttpErrorType.tokenExpired: "您账号登录已过期",
  HttpErrorType.unknown: "请求出错，请稍后重试",
  HttpErrorType.network: "网络异常，请检查网络设置",
  HttpErrorType.connectionTimeout: "网络连接超时，请检查网络设置",
  HttpErrorType.sendTimeout: "请求超时，请检查网络设置",
  HttpErrorType.receiveTimeout: "响应超时，请稍后重试",
  HttpErrorType.badResponse: "服务器异常，请稍后重试",
  HttpErrorType.cancel: "请求已取消，请重试",
};
