import 'package:flutter_application_arknights/net/dio_utils.dart';

class HHDio {
  /*
  * get 请求
  * url: 请求的url
  * isLoading: 是否显示loading加载框
  * isToastErrorMsg: 是否弹出错误信息
  * params: body参数
  * queryParameters: query参数
  * onSuccess: 成功回调
  * onError: 失败回调
  *  */
  static void get<T>(
    String url, {
    bool isLoading = true,
    bool isToastErrorMsg = true,
    Object? params,
    Map<String, dynamic>? queryParameters,
    NetSuccessCallback<T?>? onSuccess,
    NetErrorCallback? onError,
  }) {
    DioUtils.instance.requestNetwork(Method.get, url,
        onError: onError,
        onSuccess: onSuccess,
        params: params,
        queryParameters: queryParameters,
        isLoading: isLoading,
        isToastErrorMsg: isToastErrorMsg);
  }

  /*
  * post 请求
  * url: 请求的url
  * isLoading: 是否显示loading加载框
  * isToastErrorMsg: 是否弹出错误信息
  * params: body参数
  * queryParameters: query参数
  * onSuccess: 成功回调
  * onError: 失败回调
  *  */
  static void post<T>(
    String url, {
    bool isLoading = true,
    bool isToastErrorMsg = true,
    Object? params,
    Map<String, dynamic>? queryParameters,
    NetSuccessCallback<T?>? onSuccess,
    NetErrorCallback? onError,
  }) {
    DioUtils.instance.requestNetwork(Method.post, url,
        onError: onError,
        onSuccess: onSuccess,
        params: params,
        queryParameters: queryParameters,
        isLoading: isLoading,
        isToastErrorMsg: isToastErrorMsg);
  }

  /*
  * patch 请求
  * url: 请求的url
  * isLoading: 是否显示loading加载框
  * isToastErrorMsg: 是否弹出错误信息
  * params: body参数
  * queryParameters: query参数
  * onSuccess: 成功回调
  * onError: 失败回调
  *  */
  static void patch<T>(
    String url, {
    bool isLoading = true,
    bool isToastErrorMsg = true,
    Object? params,
    Map<String, dynamic>? queryParameters,
    NetSuccessCallback<T?>? onSuccess,
    NetErrorCallback? onError,
  }) {
    DioUtils.instance.requestNetwork(Method.patch, url,
        onError: onError,
        onSuccess: onSuccess,
        params: params,
        queryParameters: queryParameters,
        isLoading: isLoading,
        isToastErrorMsg: isToastErrorMsg);
  }

  /*
  * put 请求
  * url: 请求的url
  * isLoading: 是否显示loading加载框
  * isToastErrorMsg: 是否弹出错误信息
  * params: body参数
  * queryParameters: query参数
  * onSuccess: 成功回调
  * onError: 失败回调
  *  */
  static void put<T>(
    String url, {
    bool isLoading = true,
    bool isToastErrorMsg = true,
    Object? params,
    Map<String, dynamic>? queryParameters,
    NetSuccessCallback<T?>? onSuccess,
    NetErrorCallback? onError,
  }) {
    DioUtils.instance.requestNetwork(Method.put, url,
        onError: onError,
        onSuccess: onSuccess,
        params: params,
        queryParameters: queryParameters,
        isLoading: isLoading,
        isToastErrorMsg: isToastErrorMsg);
  }

  /*
  * delete 请求
  * url: 请求的url
  * isLoading: 是否显示loading加载框
  * isToastErrorMsg: 是否弹出错误信息
  * params: body参数
  * queryParameters: query参数
  * onSuccess: 成功回调
  * onError: 失败回调
  *  */
  static void delete<T>(
    String url, {
    bool isLoading = true,
    bool isToastErrorMsg = true,
    Object? params,
    Map<String, dynamic>? queryParameters,
    NetSuccessCallback<T?>? onSuccess,
    NetErrorCallback? onError,
  }) {
    DioUtils.instance.requestNetwork(Method.delete, url,
        onError: onError,
        onSuccess: onSuccess,
        params: params,
        queryParameters: queryParameters,
        isLoading: isLoading,
        isToastErrorMsg: isToastErrorMsg);
  }
}
