import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_arknights/common/shared.dart';
import 'package:flutter_application_arknights/widgets/function/createColor.dart';

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
    PersistentStorage().setStorage("url", "http://192.168.0.100:210");
    return ScreenUtilInit(
        // Size(720, 1280) (375,812)
        designSize: const Size(720, 1280),
        builder: (((context, child) => MaterialApp(
              title: 'Flutter Demo',
              debugShowCheckedModeBanner: false,
              theme: ThemeData(
                  /* brightness: Brightness.dark, */
                  primarySwatch: createMaterialColor(
                      const Color.fromARGB(255, 20, 33, 61)),
                  fontFamily: "PlayfairDisplay",
                  textTheme: const TextTheme(
                      // ignore: deprecated_member_use
                      headline3: TextStyle(
                        fontFamily: "PlayfairDisplay",
                      ),
                      // ignore: deprecated_member_use
                      button:
                          TextStyle(color: Color.fromARGB(255, 255, 0, 0)))),
              initialRoute: "/",
              onGenerateRoute: onGenerateRoute,
              routes: routes,
            ))));
  }
}
