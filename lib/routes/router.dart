import 'package:flutter/material.dart';
import 'package:flutter_application_arknights/common/shared.dart';
import 'package:flutter_application_arknights/routes/loginPages/login.dart';
import 'index.dart';

//配置路由

final Map<String, Widget Function(BuildContext)> routes = {
  '/': (context) => const index(),
  '/login': (context) => const loginPage(),
};

//固定写法
var onGenerateRoute = (RouteSettings settings) {
  final String? name = settings.name;
  final Function pageContentBuilder = routes[name] as Function;
  if (settings.arguments != null) {
    final Route route = MaterialPageRoute(
        builder: (context) =>
            pageContentBuilder(context, arguments: settings.arguments));
    return route;
  } else {
    final Route route =
        MaterialPageRoute(builder: (context) => pageContentBuilder(context));
    return route;
  }
};
