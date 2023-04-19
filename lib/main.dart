import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';

import './routes/router.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() {
  debugPaintSizeEnabled = false;
  // 顶部状态栏
  SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(412, 892),
        builder: (((context, child) => MaterialApp(
              title: 'Flutter Demo',
              debugShowCheckedModeBanner: false,
              theme: ThemeData(
                  primarySwatch: Colors.brown, fontFamily: "PlayfairDisplay"),
              initialRoute: '/',
              routes: routes,
            ))));
  }
}
