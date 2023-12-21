import 'dart:convert';
import 'dart:io';

// ignore: depend_on_referenced_packages
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_application_arknights/net/base_entity.dart';
import 'package:flutter_application_arknights/net/intercept.dart';
import 'package:flutter_application_arknights/utils/loading_utils.dart';
import 'package:flutter_application_arknights/utils/toast_utils.dart';
import '../utils/logger.dart';
import 'error_handle.dart';

/// 默认dio配置
Duration _connectTimeout = const Duration(seconds: 15);
Duration _receiveTimeout = const Duration(seconds: 15);
Duration _sendTimeout = const Duration(seconds: 10);

String _baseUrl = '124.222.122.118:210/api/';

typedef NetSuccessCallback<T> = Function(T data);
typedef NetErrorCallback = Function(int code, String msg);

class DioUtils {
  factory DioUtils() => _singleton;

  DioUtils._() {
    final BaseOptions options = BaseOptions(
      connectTimeout: _connectTimeout,
      receiveTimeout: _receiveTimeout,
      sendTimeout: _sendTimeout,

      /// dio默认json解析，这里指定返回UTF8字符串，自己处理解析。（可也以自定义Transformer实现）
      // responseType: ResponseType.plain,
      validateStatus: (_) {
        // 不使用http状态码判断状态，使用AdapterInterceptor来处理（适用于标准REST风格）
        return true;
      },
      headers: httpHeaders,
      baseUrl: _baseUrl,
      // contentType: Headers.formUrlEncodedContentType, // 适用于post form表单提交
    );
    _dio = Dio(options);

    if (!Constant.inProduction) {
      //非生产环境
      /// Fiddler抓包代理配置 https://www.jianshu.com/p/d831b1f7c45b
      // _dio.httpClientAdapter = IOHttpClientAdapter()..onHttpClientCreate = (HttpClient client) {
      //   client.findProxy = (uri) {
      //     //proxy all request to localhost:8888
      //     return 'PROXY 10.41.0.132:8888';
      //   };
      //   return client;
      // };
    }

    final List<Interceptor> interceptors = <Interceptor>[];

    /// 统一添加身份验证请求头
    interceptors.add(AuthInterceptor());

    /// 刷新Token
    interceptors.add(TokenInterceptor());

    /// 打印Log(生产模式去除)
    if (!Constant.inProduction) {
      interceptors.add(LoggingInterceptor());
    }

    /// 适配数据(根据自己的数据结构，可自行选择添加)
    interceptors.add(AdapterInterceptor());

    /// 添加拦截器
    void addInterceptor(Interceptor interceptor) {
      _dio.interceptors.add(interceptor);
    }

    interceptors.forEach(addInterceptor);
  }

  static final DioUtils _singleton = DioUtils._();

  static DioUtils get instance => DioUtils();

  static late Dio _dio;

  Dio get dio => _dio;

  // 数据返回格式统一，统一处理异常
  Future<BaseEntity<T>> _request<T>(
    String method,
    String url, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    CancelToken? cancelToken,
    Options? options,
  }) async {
    final Response<String> response = await _dio.request<String>(
      url,
      data: data,
      queryParameters: queryParameters,
      options: _checkOptions(method, options),
      cancelToken: cancelToken,
    );
    try {
      final String data = response.data.toString();
      final Map<String, dynamic> map = parseData(data);
      return BaseEntity<T>.fromJson(map);
    } catch (e) {
      debugPrint(e.toString());
      return BaseEntity<T>(ExceptionHandle.parse_error, '数据解析错误！', null);
    }
  }

  Options _checkOptions(String method, Options? options) {
    options ??= Options();
    options.method = method;
    return options;
  }

  /// 网络请求
  Future<dynamic> requestNetwork<T>(
    Method method,
    String url, {
    NetSuccessCallback<T?>? onSuccess,
    NetErrorCallback? onError,
    Object? params,
    Map<String, dynamic>? queryParameters,
    CancelToken? cancelToken,
    Options? options,
    bool isLoading = true,
    bool isToastErrorMsg = true,
  }) {
    if (isLoading) {
      HHLoading.showLoading();
    }
    return _request<T>(
      method.value,
      url,
      data: params,
      queryParameters: queryParameters,
      options: options,
      cancelToken: cancelToken,
    ).then<void>((BaseEntity<T> result) {
      if (isLoading) {
        HHLoading.dismissLoading();
      }
      if (result.code == 0) {
        onSuccess?.call(result.data);
      } else {
        _onError(result.code, result.message, onError);
        if (isToastErrorMsg) {
          showToast(result.message);
        }
      }
    }, onError: (dynamic e) {
      if (isLoading) {
        HHLoading.dismissLoading();
      }
      _cancelLogPrint(e, url);
      final NetError error = ExceptionHandle.handleException(e);
      if (isToastErrorMsg) {
        showToast(error.msg);
      }
      _onError(error.code, error.msg, onError);
    });
  }

  void _cancelLogPrint(dynamic e, String url) {
    if (e is DioException && CancelToken.isCancel(e)) {
      logPrint('取消请求接口： $url');
    }
  }

  void _onError(int? code, String msg, NetErrorCallback? onError) {
    if (code == null) {
      code = ExceptionHandle.unknown_error;
      msg = '未知异常';
    }
    logPrint('接口请求异常： code: $code, mag: $msg');
    onError?.call(code, msg);
  }
}

/// 自定义Header
Map<String, dynamic> httpHeaders = {
  'Content-Type': 'application/json; charset=UTF-8',
  'Device-type': Platform.operatingSystem, //设备类型,  iOS, 安卓, web等
  /* 'App-build': deviceInfo.buildNumber,
  'App-version': DeviceInfo.version */
};

Map<String, dynamic> parseData(String data) {
  return json.decode(data) as Map<String, dynamic>;
}

enum Method { get, post, put, patch, delete, head }

/// 使用拓展枚举替代 switch判断取值
/// https://zhuanlan.zhihu.com/p/98545689
extension MethodExtension on Method {
  String get value => ['GET', 'POST', 'PUT', 'PATCH', 'DELETE', 'HEAD'][index];
}
