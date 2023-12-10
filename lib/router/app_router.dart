import 'package:fluro/fluro.dart';
import 'package:flutter_application_arknights/router/router_path.dart';
import 'package:flutter_application_arknights/router/router_handler.dart';

class HHRouter {
  static final HHRouter _instance = HHRouter._internal();
  factory HHRouter() => _instance;
  HHRouter._internal();

  static final FluroRouter router = FluroRouter();

  void defineRoutes() {
    router.define(HHRouterPath.homePage, handler: homeHandler);
  }
}
