import 'package:flutter/material.dart';
import 'package:flutter_application_arknights/pages/page_tabbar.dart';
import 'package:flutter_application_arknights/router/app_router.dart';
import 'package:flutter_application_arknights/theme/dark/theme_dark.dart';
import 'package:flutter_application_arknights/theme/light/theme_light.dart';
import 'package:flutter_application_arknights/utils/screen_utils.dart';
import 'package:flutter_application_arknights/utils/storage_util.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void main() {
  init();
  runApp(const ProviderScope(child: MyApp()));
}

void init() async {
  WidgetsFlutterBinding.ensureInitialized();
  HHRouter().defineRoutes();
  EasyLoading.init();
  StorageUtil.init();
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ScreenUtilInit(
      designSize: HHSize.screenSize,
      //是否根据宽度/高度中的最小值适配文字
      minTextAdapt: true,
      //支持分屏尺寸
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          navigatorKey: HHRouter.globalKey,
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: lightThemeData(context),
          darkTheme: darkThemeData(context),
          onGenerateRoute: HHRouter.router.generator,
          home: const TabbarPage(),
          builder: EasyLoading.init(),
        );
      },
    );
  }
}
