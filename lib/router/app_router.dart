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
    router.define(HHRouterPath.articleCreatePage,
        handler: articleCreateHandler);
    router.define(HHRouterPath.articleMyListPage,
        handler: articleMyListHandler);
  }

  static void push(
    String path, {
    BuildContext? context,
  }) {
    router.navigateTo(context ?? currentContext, path);
  }

  static void pop(BuildContext? context) {
    Navigator.of(context ?? currentContext).maybePop();
  }

  static void replace(String path, {BuildContext? context}) {
    Navigator.pushReplacementNamed(context ?? currentContext, path);
  }
}
