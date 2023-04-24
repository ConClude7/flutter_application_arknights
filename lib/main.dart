import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_arknights/common/global.dart';
import 'package:flutter_application_arknights/widgets/createColor.dart';

import './routes/router.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() async {
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
                  /* brightness: Brightness.dark, */
                  primarySwatch: createMaterialColor(
                      const Color.fromARGB(255, 20, 33, 61)),
                  fontFamily: "PlayfairDisplay",
                  textTheme: const TextTheme(
                      headline3: TextStyle(
                        fontFamily: "PlayfairDisplay",
                      ),
                      button:
                          TextStyle(color: Color.fromARGB(255, 255, 0, 0)))),
              initialRoute: "/",
              routes: routes,
            ))));
  }
}
