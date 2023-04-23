import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_arknights/common/global.dart';
import 'package:flutter_application_arknights/routes/loginPages/login.dart';
import '../common/shared.dart';

class DartHttpUtils {
  late final Dio _dio;

  createDioInstance(BuildContext context) async {
    final token = await PersistentStorage().getStorage("token");
    print("DioGetToken:$token");
    _dio = Dio(BaseOptions(
      baseUrl: "http://192.168.0.28:210",
      headers: {
        HttpHeaders.authorizationHeader: "Bearer $token",
      },
    ));
    _dio.interceptors.add(InterceptorsWrapper(
      onError: (DioError e, handler) async {
        if (e.response?.statusCode == 401) {
          // 处理 401 错误
          print("Token无效,需要重新登录");
          PersistentStorage().removeStorage("token");
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const loginPage()),
            (route) => false,
          );
        } else if (e.response?.statusCode == 200) {}
      },
    ));
  }

  /* final Dio _dio = Dio(BaseOptions(
    baseUrl: "http://192.168.0.100:210",
    headers: {
      HttpHeaders.authorizationHeader: PersistentStorage().getStorage("token")
    },
  )); */

  //dio的GET请求
  getDio(String url, BuildContext context) async {
    await createDioInstance(context);
    final response = await _dio.get(url,
        options: Options(
          contentType: ContentType.json.toString(),
        ));

    if (response.statusCode == 200) {
      print(response.data.toString());
      return response.data;
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
        print(response.data.toString());
        return response.data;
      } else if (response.statusCode == 401) {
        print("Token无效,需要重新登录");
      }
    } catch (e) {
      print(e.toString());
    }
  }
}
