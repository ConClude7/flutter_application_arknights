import 'package:fluro/fluro.dart';
import 'package:flutter_application_arknights/pages/home/page_home.dart';

final Handler homeHandler = Handler(
  handlerFunc: (context, parameters) {
    return const MyHomePage();
  },
);
