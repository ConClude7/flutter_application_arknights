import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_arknights/router/router_path.dart';
import 'package:flutter_application_arknights/router/router_handler.dart';

/// 当前的context
BuildContext get currentContext => HHRouter.globalKey.currentContext!;

class HHRouter {
  /// 全局路由key
  static final GlobalKey<NavigatorState> globalKey =
      GlobalKey<NavigatorState>();

  static final HHRouter _instance = HHRouter._internal();
  factory HHRouter() => _instance;
  HHRouter._internal();

  static final FluroRouter router = FluroRouter();

  void defineRoutes() {
    router.define(HHRouterPath.homePage, handler: homeHandler);
    router.define(HHRouterPath.loginPage, handler: loginHandler);
  }

  static void pop(BuildContext context) {
    Navigator.of(context).maybePop();
  }
}
