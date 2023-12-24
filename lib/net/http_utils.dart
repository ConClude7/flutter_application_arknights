// ignore_for_file: constant_identifier_names, duplicate_ignore

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_application_arknights/net/api/api_result.dart';
import 'package:flutter_application_arknights/net/http_config.dart';
import 'package:flutter_application_arknights/net/http_error.dart';
import 'package:flutter_application_arknights/utils/loading_utils.dart';
import 'package:flutter_application_arknights/utils/logger.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

/// http请求成功回调
typedef RequestSuccessCallback<T> = void Function(T data);

/// 失败回调
typedef RequestErrorCallback = void Function(HttpError error);

/// @desc  封装 http 请求
/// 1>：首先从本地数据库的缓存中读取数据，如果缓存有数据，就直接显示列表数据，同时去请求服务器，如果服务器返回数据了，这个时候就去比对服务器返回的数据与缓存中的数据，看是否一样；
/// 2>：如果比对结果是一样，那么直接return返回，不做任何操作；
/// 3>：如果比对结果不一样，就去刷新列表数据，同时把之前数据库中的数据删除，然后存储新的数据；

class HHDio {
  HHLog get log => HHLog.http;

  // ignore: duplicate_ignore
  /// http request methods
  // ignore: constant_identifier_names
  static const String GET = 'GET';
  static const String POST = 'POST';
  static const String PUT = 'PUT';
  static const String DELETE = 'DELETE';

  Dio? _client;

  static final HHDio _instance = HHDio._internal();

  factory HHDio() => _instance;

  Dio? get client => _client;

  /// 创建 dio 实例对象
  HHDio._internal() {
    if (_client == null) {
      /// 全局属性：请求前缀、连接超时时间、响应超时时间

      // if (UserInfo.userAccessToken.isNotEmpty) {
      //   logPrint('用户token ${UserInfo.userAccessToken.isNotEmpty}');
      // } else {
      //   logPrint(
      //       '获取token ${StorageUtils.preferences?.getString(StorageKey.accessToken) ?? ''}');
      // }

      BaseOptions options = BaseOptions(
        baseUrl: HttpConfig.baseURL,
        connectTimeout: HttpConfig.timeOut,
        receiveTimeout: HttpConfig.receiveTimeout,
        headers: HttpConfig.headersJson,
        // responseType: ResponseType.plain,
      );
      _client = Dio(options);
      // _configureHttpProxy();
      _prettyDioLogger();
    }
  }

  /// 打印dio日志
  _prettyDioLogger() {
    if (!HHLog.httpDetail.isShowLog) return;
    _client?.interceptors.add(PrettyDioLogger(
        requestHeader: false,
        requestBody: true,
        responseBody: true,
        responseHeader: false,
        error: true,
        compact: true,
        maxWidth: 100));
  }

  /// 当前的服务器时间戳
  String? timestamp;

  /// 当前的服务器时间
  /* DateTime? now() {
    return timestamp != null
        ? DateTimeUtils.fromUtcMillisecondsStringSinceEpoch(timestamp!)
        : null;
  } */

  // void _configureHttpProxy() async {
  //   // 生产包关闭代理功能
  //   if (!SPEnvConfig.isRelease) {
  //     SPNativeMethods.getHttpProxy().then((map) {
  //       if (map == null || map is Map == false) {
  //         return;
  //       }
  //       (_client?.httpClientAdapter as DefaultHttpClientAdapter)
  //           .onHttpClientCreate = (HttpClient client) {
  //         client.badCertificateCallback =
  //             (X509Certificate cert, String host, int port) {
  //           return true;
  //         };
  //         client.findProxy = (uri) {
  //           return 'PROXY ${map['host']}:${map['port']}';
  //         };
  //         return null;
  //       };
  //     });
  //   }
  // }

  ///Get网络请求
  ///
  ///[path] 网络请求地址不包含域名
  ///[params] 拼在请求链接里的参数
  ///[options] 请求配置
  ///[successCallback] 请求成功回调
  ///[errorCallback] 请求失败回调
  ///[cancelToken] 同一个CancelToken可以用于多个请求，当一个CancelToken取消时，所有使用该CancelToken的请求都会被取消
  ///[isShowLoading] 是否自动展示加载和失败遮罩 默认不展示
  ///[isCheckLogin] 是否需要检验登录 默认校验
  Future<dynamic> get({
    required String path,
    Map<String, dynamic>? params,
    RequestSuccessCallback? successCallback,
    Options? options,
    RequestErrorCallback? errorCallback,
    CancelToken? cancelToken,
    bool? isShowLoading,
    bool? isCheckLogin,
  }) async {
    return request(
        path: path,
        method: GET,
        params: params,
        options: options,
        successCallback: successCallback,
        errorCallback: errorCallback,
        cancelToken: cancelToken,
        isShowLoading: isShowLoading,
        isCheckLogin: isCheckLogin);
  }

  ///PUT网络请求
  ///
  ///[path] 网络请求地址不包含域名
  ///[params] 拼在请求链接里的参数
  ///[data] 放在body里的参数
  ///[options] 请求配置
  ///[successCallback] 请求成功回调
  ///[errorCallback] 请求失败回调
  ///[cancelToken] 同一个CancelToken可以用于多个请求，当一个CancelToken取消时，所有使用该CancelToken的请求都会被取消
  ///[isShowLoading] 是否自动展示加载和失败遮罩 默认不展示
  ///[isCheckLogin] 是否需要检验登录 默认校验
  Future<dynamic> put({
    required String path,
    required Map<String, dynamic> params,
    Map<String, dynamic>? data,
    RequestSuccessCallback? successCallback,
    Options? options,
    RequestErrorCallback? errorCallback,
    CancelToken? cancelToken,
    bool? isShowLoading,
    bool? isCheckLogin,
  }) async {
    return request(
        path: path,
        method: PUT,
        params: params,
        data: data,
        options: options,
        successCallback: successCallback,
        errorCallback: errorCallback,
        cancelToken: cancelToken,
        isShowLoading: isShowLoading,
        isCheckLogin: isCheckLogin);
  }

  ///DELETE 网络请求
  ///
  ///[path] 网络请求地址不包含域名
  ///[params] 拼在请求链接里的参数
  ///[options] 请求配置
  ///[successCallback] 请求成功回调
  ///[errorCallback] 请求失败回调
  ///[cancelToken] 同一个CancelToken可以用于多个请求，当一个CancelToken取消时，所有使用该CancelToken的请求都会被取消
  ///[isShowLoading] 是否自动展示加载和失败遮罩 默认不展示
  ///[isCheckLogin] 是否需要检验登录 默认校验
  Future<dynamic> delete({
    required String path,
    Map<String, dynamic>? params,
    RequestSuccessCallback? successCallback,
    Options? options,
    RequestErrorCallback? errorCallback,
    CancelToken? cancelToken,
    bool? isShowLoading,
    bool? isCheckLogin,
  }) async {
    return request(
        path: path,
        method: DELETE,
        params: params,
        options: options,
        successCallback: successCallback,
        errorCallback: errorCallback,
        cancelToken: cancelToken,
        isShowLoading: isShowLoading,
        isCheckLogin: isCheckLogin);
  }

  //POST网络请求
  ///
  ///[path] 网络请求地址不包含域名
  ///[params] 放在body里的参数
  ///[queryParams] 拼在请求链接里的参数
  ///[options] 请求配置
  ///[successCallback] 请求成功回调
  ///[errorCallback] 请求失败回调
  ///[cancelToken] 同一个CancelToken可以用于多个请求，当一个CancelToken取消时，所有使用该CancelToken的请求都会被取消
  ///[isShowLoading] 是否自动展示加载和失败遮罩 默认不展示
  ///[isCheckLogin] 是否需要检验登录 默认校验
  Future<dynamic> post({
    required String path,
    required dynamic params,
    Map<String, dynamic>? queryParams,
    RequestSuccessCallback? successCallback,
    Options? options,
    RequestErrorCallback? errorCallback,
    CancelToken? cancelToken,
    bool? isShowLoading,
    bool? isCheckLogin,
  }) async {
    return request(
        path: path,
        method: POST,
        data: params,
        params: queryParams,
        options: options,
        successCallback: successCallback,
        errorCallback: errorCallback,
        cancelToken: cancelToken,
        isShowLoading: isShowLoading,
        isCheckLogin: isCheckLogin);
  }

  ///统一网络请求
  ///
  ///[path] 网络请求地址不包含域名
  ///[data] post 请求参数
  ///[params] url请求参数支持restful
  ///[options] 请求配置
  ///[successCallback] 请求成功回调
  ///[errorCallback] 请求失败回调
  ///[cancelToken] 同一个CancelToken可以用于多个请求，当一个CancelToken取消时，所有使用该CancelToken的请求都会被取消
  ///[isShowLoading] 是否自动展示加载和失败遮罩 默认不展示
  ///[isCheckLogin] 是否自动检验登录 默认校验
  Future<dynamic> request({
    required String path,
    String? method,
    dynamic data,
    Map<String, dynamic>? params,
    Options? options,
    RequestSuccessCallback? successCallback,
    RequestErrorCallback? errorCallback,
    ProgressCallback? onReceiveProgress,
    CancelToken? cancelToken,
    bool? isShowLoading,
    bool? isCheckLogin,
  }) async {
    if (isShowLoading == true) {
      HHLoading.showLoading();
    }

    /// 检查网络是否连接
    ConnectivityResult connectivityResult =
        await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.none) {
      return _handleError(HttpError.type(HttpErrorType.network),
          callback: errorCallback,

          /// 产品需求 网络异常都要抛出toast
          isShowLoading: true);
    }

    String url = '${HttpConfig.baseURL}/$path';

    /// 设置默认值
    params = params ?? {};
    // if (params['token'] == null) {
    //   /// TDDO 设置token
    //   params['token'] =
    //       StorageUtils.preferences?.getString(StorageKey.accessToken) ?? '';
    // }

    // if (url.contains('mobile-bff')) {
    //   params['terminal'] = 3;
    if ((method == POST || method == PUT) && data is Map) {
      Map temp = Map.from(data);

      data = temp;
    }
    // }
    method ??= GET;
    options ??= Options();
    options.method = method;

    if (method == GET) {
      url = _restfulUrl(url, params);
    }

    try {
      Response<Map<String, dynamic>> response = await _client!.request(
        url,
        onReceiveProgress: onReceiveProgress,
        data: data ?? params,
        queryParameters: params,
        options: options,
        cancelToken: cancelToken,
      );

      String? statusCode = response.data?["code"].toString();

      log.success(response.realUri.toString());

      if (method == 'POST') {
        log.success('Post参数：$data');
      }
      log.success('Response：${response.data}');

      if (isShowLoading == true) {
        HHLoading.dismissLoading();
      }
      if (isShowLoading == true) {
        HHLoading.dismissLoading();
      }
      if (statusCode == "200") {
        //成功
        if (successCallback != null) {
          if (response.data is bool) {
            successCallback({'data': response.data!['data']});
          } else {
            if (response.data is Map) {
              var time = response.data?['timestamp'];
              if (time is String && time.isNotEmpty) {
                timestamp = time;
              }
            }
            successCallback(response.data);
          }
        }
        return response.data;
      } else {
        //失败
        String? message;
        if (response.data is Map) {
          message = response.data?['message'];
        }
        return _handleError(
          HttpError('${HttpErrorType.business.code}_$statusCode',
              message ?? HttpErrorType.business.message,
              response: response.data),
          callback: errorCallback,
          isShowLoading: isShowLoading,
        );
      }
    } on DioException catch (err) {
      if (isShowLoading == true) {
        HHLoading.dismissLoading();
      }

      /// 401-未登录/账号被顶 601-Token失效
      if (isCheckLogin != false &&
          (err.response?.statusCode == 401 ||
              err.response?.statusCode == 601)) {
        ///TDDO 调用登录接口
        // LoginUtils.reLogin();
        return _handleError(
          HttpError.type(HttpErrorType.tokenExpired, response: {'error': err}),
          callback: errorCallback,
          isShowLoading: true,
        );
      } else if (err.type != DioExceptionType.cancel) {
        log.error(err.requestOptions.uri.toString());
        return _handleError(
          statusCode: err.response?.statusCode,
          HttpError.dioError(err as DioExceptionType),
          callback: errorCallback,
          isShowLoading: isShowLoading,
        );
      }
    } catch (err) {
      if (isShowLoading == true) {
        HHLoading.dismissLoading();
      }

      var message = HttpErrorType.unknown.message;
      if (kDebugMode) {
        message = FlutterErrorDetails(exception: err).exceptionAsString();
      }
      return _handleError(
        HttpError(HttpErrorType.unknown.code, message,
            response: {'error': err}),
        callback: errorCallback,
        isShowLoading: isShowLoading == true && kDebugMode,
      );
    }
  }

  Future<HttpError> _handleError(HttpError error,
      {required RequestErrorCallback? callback,
      required bool? isShowLoading,
      int? statusCode}) async {
    log.error(error.toString());
    if (callback != null) {
      callback(error);
    }
    if (isShowLoading == true) {
      String message = error.response?["message"] ?? error.message;
      HHLoading.showError(msg: message);
    }
    return error;
  }

  ///上传文件
  ///
  ///[path] 网络请求地址不包含域名
  ///[data] post 请求参数
  ///[params] url请求参数支持restful
  ///[options] 请求配置
  ///[successCallback] 请求成功回调
  ///[errorCallback] 请求失败回调
  ///[onReceiveProgress] 上传进度回调
  ///[cancelToken] 同一个CancelToken可以用于多个请求，当一个CancelToken取消时，所有使用该CancelToken的请求都会被取消
  ///[isShowLoading] 是否自动展示加载和失败遮罩 默认不展示
  ///[isCheckLogin] 是否需要检验登录 默认校验
  Future<dynamic> upload({
    required String path,
    RequestSuccessCallback? successCallback,
    Map<String, dynamic>? params,
    dynamic data,
    Options? options,
    RequestErrorCallback? errorCallback,
    ProgressCallback? onReceiveProgress,
    CancelToken? cancelToken,
    bool? isShowLoading,
    bool? isCheckLogin,
  }) async {
    options ??= Options();
    options.receiveTimeout = const Duration(seconds: 0);
    return request(
        path: path,
        method: POST,
        params: params,
        data: data,
        options: options,
        successCallback: successCallback,
        errorCallback: errorCallback,
        onReceiveProgress: onReceiveProgress,
        cancelToken: cancelToken,
        isShowLoading: isShowLoading,
        isCheckLogin: isCheckLogin);
  }

  ///下载文件
  ///
  ///[url] 下载地址
  ///[savePath] 文件保存路径
  ///[onReceiveProgress] 下载进度
  ///[options] 请求配置
  ///[successCallback] 请求成功回调
  ///[errorCallback] 请求失败回调
  Future download({
    required String url,
    required savePath,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
    Options? options,
    RequestSuccessCallback? successCallback,
    RequestErrorCallback? errorCallback,
  }) async {
    /// 检查网络是否连接
    ConnectivityResult connectivityResult =
        await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.none) {
      return _handleError(HttpError.type(HttpErrorType.network),
          callback: errorCallback,

          /// 产品需求 网络异常都要抛出toast
          isShowLoading: true);
    }

    try {
      Response response = await _client!.download(url, savePath,
          onReceiveProgress: onReceiveProgress,
          options: options,
          cancelToken: cancelToken);
      //成功
      if (successCallback != null) {
        successCallback(response.data);
      }
    } on DioExceptionType catch (e) {
      if (errorCallback != null && e != DioExceptionType.cancel) {
        errorCallback(HttpError.dioError(e));
      }
    } catch (e) {
      if (errorCallback != null) {
        errorCallback(
            HttpError.type(HttpErrorType.unknown, response: {'error': e}));
      }
    }
  }

  ///restful处理
  String _restfulUrl(String url, Map<String, dynamic> params) {
    // restful 请求处理
    // /gysw/search/hist/:user_id        user_id=27
    // 最终生成 url 为     /gysw/search/hist/27
    params.forEach((key, value) {
      if (url.contains(key)) {
        url = url.replaceAll(':$key', value.toString());
      }
    });
    return url;
  }

  /// 解析请求结果
  /// [fromJson] 解析model
  ApiResult<T> transformResult<T>(dynamic result, {FromJson<T>? fromJson}) {
    try {
      if (result is HttpError) {
        return ApiResult<T>.fromJsonHttpErr(result);
      }

      return ApiResult<T>.fromJson(result, fromJson);
    } catch (e) {
      if (EasyLoading.isShow) {
        HHLoading.dismissLoading();
      }
      // 类型转换失败
      final httpError =
          HttpError.type(HttpErrorType.unknown, response: {'error': e});
      return ApiResult<T>.fromJsonHttpErr(httpError);
    }
  }
}
