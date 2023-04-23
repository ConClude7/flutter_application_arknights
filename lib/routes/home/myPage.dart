import 'dart:math';
import 'dart:ui';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_arknights/models/index.dart';
import 'package:flutter_application_arknights/routes/home/setting.dart';
import 'package:flutter_application_arknights/widgets/userCard.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:particles_flutter/component/painter.dart';
import 'package:particles_flutter/particles_flutter.dart';

import '../../common/shared.dart';
import '../../net/httpServe.dart';
import '../../widgets/3dCard.dart';
import '../../widgets/refreshing.dart';

class myPage extends StatefulWidget {
  const myPage({super.key});

  @override
  State<myPage> createState() => _myPageState();
}

class _myPageState extends State<myPage> {
  late Future<User> _futureUser;

  final EdgeInsets pagePadding = EdgeInsets.symmetric(horizontal: 25.sp);

  @override
  void initState() {
    super.initState();
    _futureUser = getUser();
  }

  Future<User> getUser() async {
    // 查询用户
    var res = await DartHttpUtils().getDio('/api/users', context)
        as Map<String, dynamic>;
    return User.fromJson(res);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<User>(
        future: _futureUser,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            User user = snapshot.data!;
            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                userCard(pagePadding, user),
                Container(
                  width: double.infinity,
                  padding: pagePadding,
                  margin: EdgeInsets.only(top: 20.sp),
                  child: settingCards(),
                )
              ],
            );
          } else if (snapshot.hasError) {
            return Text("${snapshot.error}");
          }
          //等待进度条.
          return Center(
            child: refreshWidget,
          );
        });
  }
}
