import 'dart:io';
import 'package:dio/dio.dart';

class DartHttpUtils {
  //配置dio，通过BaseOptions
  final Dio _dio = Dio(BaseOptions(baseUrl: "http://192.168.0.28:210"));

  //dio的GET请求
  getDio(String url, Map data) async {
    _dio
        .get(url,
            data: data,
            options: Options(
              contentType: ContentType.json.toString(),
            ))
        .then((Response response) {
      if (response.statusCode == 200) {
        print(response.data.toString());
      }
    });
  }

  //发送POST请求，application/json
  postJsonDio(url, Map data) async {
    _dio
        .post(url,
            data: data,
            options: Options(
              contentType: ContentType.json.toString(),
            ))
        .then((Response response) {
      if (response.statusCode == 200) {
        /*     print(response.data.toString()); */
        return response.data;
      }
    }).catchError((error) {
      print(error.toString());
    });
  }
}
