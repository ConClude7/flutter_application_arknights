import 'package:flutter_application_arknights/net/net_utlis.dart';
import 'package:flutter_application_arknights/utils/loading_utils.dart';

class LoginService {
  static Future pswLogin(
      {required String userName, required String password}) async {
    HHDio.post(
      'users/login',
      onSuccess: (data) {},
      onError: (code, msg) {
        HHLoading.showError(msg: msg);
      },
    );
  }
}
