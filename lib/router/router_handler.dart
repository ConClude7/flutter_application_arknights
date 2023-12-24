import 'package:fluro/fluro.dart';
import 'package:flutter_application_arknights/pages/login/pages/page_login_psw.dart';
import 'package:flutter_application_arknights/pages/my/pages/page_article_create.dart';
import 'package:flutter_application_arknights/pages/my/pages/page_article_mylist.dart';
import 'package:flutter_application_arknights/pages/page_tabbar.dart';

/// 首页
final Handler homeHandler = Handler(
  handlerFunc: (context, parameters) {
    return const TabbarPage();
  },
);

/// 登录页
final Handler loginHandler = Handler(
  handlerFunc: (context, parameters) {
    return const LoginPasswordPage();
  },
);

/// 发布页
final Handler articleCreateHandler = Handler(
  handlerFunc: (context, parameters) {
    return const PageArticleCreate();
  },
);

/// 我的文章页
final Handler articleMyListHandler = Handler(
  handlerFunc: (context, parameters) {
    return const PageMyArticles();
  },
);
