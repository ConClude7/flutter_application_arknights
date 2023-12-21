import 'package:fluro/fluro.dart';
import 'package:flutter_application_arknights/pages/home/page_home.dart';
import 'package:flutter_application_arknights/pages/login/pages/page_login_psw.dart';

/// 首页
final Handler homeHandler = Handler(
  handlerFunc: (context, parameters) {
    return const MyHomePage();
  },
);

/// 登录页
final Handler loginHandler = Handler(
  handlerFunc: (context, parameters) {
    return const LoginPasswordPage();
  },
);
