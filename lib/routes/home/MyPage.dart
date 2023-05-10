import 'package:flutter/material.dart';
import 'package:flutter_application_arknights/models/index.dart';
import 'package:flutter_application_arknights/net/httpServe.dart';
import 'package:flutter_application_arknights/routes/home/setting.dart';
import 'package:flutter_application_arknights/widgets/common/userCard.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loader_skeleton/loader_skeleton.dart';

class MyPage extends StatefulWidget {
  const MyPage({super.key});

  @override
  State<MyPage> createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  late Future<User> _futureUser;

  final EdgeInsets pagePadding = EdgeInsets.symmetric(horizontal: 25.sp);

  @override
  void initState() {
    super.initState();
    /* PersistentStorage().removeStorage("token"); */
    _futureUser = getUser();
  }

  Future<User> getUser() async {
    // 查询用户
    var res = await DartHttpUtils().getDio('/api/users', context)
        as Map<String, dynamic>;
    print(res);
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
                UserCard(pagePadding, user),
                Container(
                  width: double.infinity,
                  padding: pagePadding,
                  margin: EdgeInsets.only(top: 20.sp),
                  child: const SettingCards(),
                )
              ],
            );
          } else if (snapshot.hasError) {
            return Text("${snapshot.error}");
          }
          //等待进度条.
          return Column(
            children: [
              SizedBox(
                height: 50.sp,
              ),
              DarkCardSkeleton(
                isCircularImage: true,
                isBottomLinesActive: true,
              )
            ],
          );
        });
  }
}
