import 'package:flutter/material.dart';
import 'package:flutter_application_arknights/routes/Login.dart';
import 'package:flutter_application_arknights/routes/pages/ArticleList.dart';
import 'package:flutter_application_arknights/routes/pages/article.dart';
import 'package:flutter_application_arknights/routes/home/index.dart';

//配置路由

final Map<String, Widget Function(BuildContext)> routes = {
  '/': (context) => const Index(),
  '/login': (context) => const LoginPage(),
  '/article': (context) => const ArticlePage(),
  '/myArticles': (context) => const ArticleListPage(),
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
