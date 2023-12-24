import 'package:flutter/services.dart';
import 'package:flutter_application_arknights/net/api/api_page.dart';
import 'package:flutter_application_arknights/net/http_error.dart';

typedef FromJson<T> = T Function(dynamic json);

/*
* 转基本对象对象、包括Map、List
* */
FromJson<T> fromJsonPrimitive<T>() => (json) => json as T;

/*
* 转List对象、并将元素转为对应model
* */
FromJson<List<T>> fromJsonList<T>(FromJson<T> fromJson) => (json) {
      List<T> list = [];
      if (json != null && json is List) {
        list = json.map((e) => fromJson(e)).toList();
      }
      return list;
    };

/*
* 分页数据专用
* */
FromJson<ApiPaging<T>> fromJsonPagingResult<T>(FromJson<T> fromJson) =>
    (json) => ApiPaging.fromJson(json, fromJson);

class ApiResult<T> {
  int? status;
  String? error;
  String? message;
  String? timestamp;
  T? data;

  ApiResult({
    this.status,
    this.error,
    this.message,
    this.timestamp,
    this.data,
  });

  bool get success => status == 200;

  ApiResult.fromJson(Map<String, dynamic> json, [FromJson<T>? fromJson]) {
    status = json['status'];
    error = json['error'] ?? '';
    message = json['message'] ?? '';
    timestamp = json['timestamp'] ?? '';
    final result = json['data'];

    if (result != null) {
      if (fromJson != null) {
        data = fromJson(result);
      } else if (result is T) {
        data = result;
      }
    }
  }

  ApiResult.fromResult(result, [FromJson<T>? fromJson]) {
    var json = Map<String, dynamic>.from(result);
    status = json['status'];
    error = json['error'] ?? '';
    message = json['message'] ?? '';
    timestamp = json['timestamp'] ?? '';
    final res = json['data'];
    if (res != null) {
      if (fromJson != null) {
        data = fromJson(Map<String, dynamic>.from(res));
      } else if (res is T) {
        data = res;
      }
    }
  }

  /// http error
  ApiResult.fromJsonHttpErr(HttpError? error) {
    status = errorCode(error?.type);
    message = error?.message ?? '请求错误，请稍后重试';
  }

  /// method channel error
  ApiResult.fromJsonChannelErr(PlatformException? error) {
    status = int.parse(error?.code ?? '998');
    message = error?.message ?? '请求错误，请稍后重试';
  }

  /// 异常code转换
  /// [errorType] 异常类型
  int errorCode(HttpErrorType? errorType) {
    switch (errorType) {
      case HttpErrorType.tokenExpired: // 登录失效
        return 1000;
      case HttpErrorType.business: // 业务异常错误类型
        return 1001;
      case HttpErrorType.unknown: // 未知类型的请求错误，如参数解析错误
        return 1002;
      case HttpErrorType.network: // 无网络
        return 1003;
      case HttpErrorType.badResponse: // 后端错误，如404等
        return 1004;
      case HttpErrorType.connectionTimeout:
      case HttpErrorType.sendTimeout:
      case HttpErrorType.receiveTimeout:
        return 1005;
      case HttpErrorType.cancel: // 用户取消
        return 1007;
      case HttpErrorType.other: // 其他错误
        return 1008;
      default: // 未知错误
        return 9999;
    }
  }
}
