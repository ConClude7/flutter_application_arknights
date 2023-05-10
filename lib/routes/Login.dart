import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_arknights/net/httpServe.dart';
import 'package:flutter_login/flutter_login.dart';

import '../common/shared.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  Duration get loginTime => const Duration(milliseconds: 2250);

  @override
  void initState() {
    super.initState();
    checkToken();
  }

  Future<void> checkToken() async {
    final token = await PersistentStorage().getStorage("token");
    if (token != null) {
      // ignore: use_build_context_synchronously
      Navigator.pushNamedAndRemoveUntil(
        context,
        '/',
        (route) => false,
      );
    }
  }

  var resBack = (res) {
    if (res['message'] == "Success") {
      return null;
    } else {
      return res['message'];
    }
  };
// 登录
  Future<String?> _authUser(LoginData data) async {
    final res = await DartHttpUtils().postJsonDio('/api/users/login',
        {"username": data.name, "passWord": data.password}, context);
    await PersistentStorage().setStorage("token", res["token"]);
    if (res['message'] == "Success") {
      return null;
    } else {
      return res['message'];
    }
  }

// 注册
  Future<String?> _signupUser(data) async {
    debugPrint('Signup Name: ${data.name}, Password: ${data.password}');
    // 添加用户
    final res = await DartHttpUtils().postJsonDio(
        '/api/users/register',
        {
          "username": data.name,
          "passWord": data.password,
          "type": "User",
          "email": "",
          "says": "大家都不是很爱发表言论",
        },
        context);
    await PersistentStorage().setStorage("token", res["token"]);
    return resBack(res);
  }

// 忘记密码
  Future<String?> _recoverPassword(String name) {
    debugPrint('Name: $name');
    return Future.delayed(loginTime).then((_) {
      return null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return FlutterLogin(
      title: "Moro Boat",
      userType: LoginUserType.name,
      userValidator: (value) {},
      onSignup: _signupUser,
      onSubmitAnimationCompleted: () {
        Navigator.pushNamedAndRemoveUntil(
          context,
          '/',
          (route) => false,
        );
      },
      onLogin: _authUser,
      onRecoverPassword: _recoverPassword,
      showDebugButtons: false,
      // 忘记密码功能
      hideForgotPasswordButton: false,
      messages: LoginMessages(),
    );
  }
}
