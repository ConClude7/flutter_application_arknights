import 'package:flutter_application_arknights/models/model_userinfo.dart';
import 'package:flutter_application_arknights/net/http_utils.dart';
import 'package:flutter_application_arknights/router/app_router.dart';
import 'package:flutter_application_arknights/router/router_path.dart';
import 'package:flutter_application_arknights/utils/storage_util.dart';

class ServiceMy {
  static Future<Userinfo> getMyInfo() async {
    late final Userinfo userinfo;
    await HHDio().get(
      path: 'user',
      isShowLoading: false,
      successCallback: (data) {
        userinfo = Userinfo.fromMap(data['data']);
      },
      errorCallback: (error) {
        HHRouter.push(HHRouterPath.loginPage);
      },
    );
    return userinfo;
  }

  static Future<void> deleteMe() async {
    await HHDio().delete(
      path: 'user',
      successCallback: (data) {
        StorageUtil.clean();
        HHRouter.replace(HHRouterPath.loginPage);
      },
    );
  }
}
