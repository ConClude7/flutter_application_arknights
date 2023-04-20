import 'dart:io';
import 'package:dio/dio.dart';
import '../common/shared.dart';

class DartHttpUtils {
  static Future<Dio> createDioInstance() async {
    final token = await PersistentStorage().getStorage("token");
    final Dio dio = Dio(BaseOptions(
      baseUrl: "http://192.168.0.100:210",
      headers: {
        HttpHeaders.authorizationHeader: token,
      },
    ));
    return dio;
  }

  final Dio _dio = createDioInstance() as Dio;

  //dio的GET请求
  getDio(String url, Map data) async {
    await _dio
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
        /* print(response.data.toString()); */
        return response.data;
      } else {
        print('Failed with status code ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }
}
