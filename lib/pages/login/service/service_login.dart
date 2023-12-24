import 'package:flutter_application_arknights/net/http_utils.dart';
import 'package:flutter_application_arknights/router/app_router.dart';
import 'package:flutter_application_arknights/router/router_path.dart';
import 'package:flutter_application_arknights/utils/logger.dart';
import 'package:flutter_application_arknights/utils/storage_util.dart';

class LoginService {
  static Future register(
      {required String userName, required String password}) async {
    await HHDio().post(
      path: 'user/register',
      params: {
        'nickname': userName,
        'password': password,
      },
      successCallback: (data) {
        _setToken(data);
        HHRouter.push(HHRouterPath.homePage);
      },
    );
  }

  static Future<void> login(
      {required String userName, required String password}) async {
    await HHDio().post(
      path: 'user/login',
      params: {
        'nickname': userName,
        'password': password,
      },
      successCallback: (data) {
        _setToken(data['data']);
        HHRouter.push(HHRouterPath.homePage);
      },
    );
  }

  static Future<void> _setToken(dynamic data) async {
    final String? token = data?['token'];
    logPrint('获取token:$token');
    if (token != null && token != '') {
      StorageUtil.setString(StorageKey.token, token);
    }
  }
}
