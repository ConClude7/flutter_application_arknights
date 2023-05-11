import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_arknights/net/httpError.dart';
import 'package:flutter_application_arknights/routes/Login.dart';
import '../common/shared.dart';

class DartHttpUtils {
  late final Dio _dio;

  createDioInstance(BuildContext context) async {
    final token = await PersistentStorage().getStorage("token");
    _dio = Dio(BaseOptions(
      baseUrl: "http://192.168.0.28:210",
      connectTimeout: const Duration(seconds: 2),
      headers: {
        HttpHeaders.authorizationHeader: "Bearer $token",
      },
    ));
    _dio.interceptors.add(InterceptorsWrapper(
      onError: (DioError e, handler) async {
        if (e.response?.statusCode == 401) {
          // 处理 401 错误
          // ignore: avoid_print
          print("Token无效,需要重新登录");
          PersistentStorage().removeStorage("token");
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const LoginPage()),
            (route) => false,
          );
        } else {
          HttpError.dioError(context, e);
        }
      },
    ));
  }

  //dio的GET请求
  getDio(String url, BuildContext context) async {
    await createDioInstance(context);
    final response = await _dio.get(url,
        options: Options(
          contentType: ContentType.json.toString(),
        ));

    if (response.statusCode == 200) {
      // ignore: avoid_print
      /* print(response.data.toString()); */
      return response.data;
    }
  }

  deleteDio(String url, BuildContext context) async {
    await createDioInstance(context);
    final response = await _dio.delete(url);
    if (response.statusCode == 200) {
      print(response);
    }
  }

  //发送POST请求，application/json
  postJsonDio(url, Map data, BuildContext context) async {
    await createDioInstance(context);
    try {
      final response = await _dio.post(
        url,
        data: data,
        options: Options(
          contentType: ContentType.json.toString(),
        ),
      );
      if (response.statusCode == 200) {
        // 将打印语句移到if语句块内部
        // ignore: avoid_print
        print(response.data.toString());
        return response.data;
      } else if (response.statusCode == 401) {
        // ignore: avoid_print
        print("Token无效,需要重新登录");
      }
    } catch (e) {
      // ignore: avoid_print
      print(e.toString());
    }
  }

  //发送POST请求，上传类型为图片文件
  postFileDio(
    url,
    FormData data,
    BuildContext context,
    Function(double) progressCallback,
  ) async {
    await createDioInstance(context);
    try {
      final response = await _dio.post(
        url,
        data: data,
        options: Options(
          headers: {HttpHeaders.contentTypeHeader: "multipart/form-data"},
        ),
        onSendProgress: (sent, total) {
          double progress = sent / total;
          // 在这里更新进度条的状态或显示进度信息
          /* print('上传进度：${progress * 100}%'); */
          // 在这里调用回调函数，传递进度信息
          progressCallback(progress);
        },
      );
      if (response.statusCode == 200) {
        // 将打印语句移到if语句块内部
        // ignore: avoid_print
        print(response.data.toString());
        return response.data;
      } else if (response.statusCode == 401) {
        // ignore: avoid_print
        print("Token无效,需要重新登录");
      }
    } catch (e) {
      // ignore: avoid_print
      print(e.toString());
    }
  }
}
