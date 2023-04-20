import 'dart:math';
import 'dart:ui';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../common/shared.dart';
import '../../net/httpServe.dart';

class myPage extends StatefulWidget {
  const myPage({super.key});

  @override
  State<myPage> createState() => _myPageState();
}

class _myPageState extends State<myPage> {
  @override
  void initState() {
    super.initState();
  }

  void loading() async {
    // 添加用户
    /* DartHttpUtils().postJsonDio('/api/users', {
      "userId": "123456789qwer",
      "username": "Jhin",
      "passWord": "123456",
      "type": "Creater",
      "email?": "807797697@qq.com",
      "says": "大家都不是很爱发表言论",
      "created": "2024-04-18-19:44:00",
      "updated": "2024-04-18-19:44:00",
      "lastLogin": "2024-04-18-19:44:00"
    }); */
    // 查询用户
    /* DartHttpUtils().getDio('/api/users', {"userId": "123456789qwer"}); */
    // 登录

    var p = PersistentStorage();

    var data = await DartHttpUtils().postJsonDio(
        '/api/users/login', {"userId": "123456789qwer", "passWord": "123456"});
    print(data);
    /* print(p.getStorage("token")); */
  }

  @override
  Widget build(BuildContext context) {
    loading();
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 25.sp),
          margin: EdgeInsets.only(top: 50.sp),
          child: Container(
            clipBehavior: Clip.hardEdge,
            width: double.infinity,
            height: 100.sp,
            decoration: BoxDecoration(
                color: const Color.fromARGB(100, 34, 34, 34),
                borderRadius: BorderRadius.all(Radius.circular(2.sp)),
                border: Border.all(
                    color: const Color.fromARGB(255, 255, 255, 255),
                    width: 1.sp,
                    style: BorderStyle.solid,
                    strokeAlign: StrokeAlign.inside)),
            child: CustomPaint(
              painter: _DiagonalLinesPainter(),
            ),
          ),
        )
      ],
    );
  }
}

class _DiagonalLinesPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color.fromARGB(180, 255, 255, 255)
      ..strokeWidth = 1.sp;

    final paintRight = Paint()
      ..color = const Color.fromARGB(180, 255, 255, 255)
      ..strokeWidth = 3.sp;

    // 右下角斜线
    for (var i = 0; i < 10; i++) {
      canvas.drawLine(Offset(size.width - (4 * i).sp, size.height),
          Offset(size.width, size.height - (4 * i).sp), paint);
    }
    // 右边垂直线
    for (var i = 0; i < 3; i++) {
      canvas.drawLine(Offset(size.width - (4 * (i + 1)).sp, 0),
          Offset(size.width - (4 * (i + 1)), size.height), paintRight);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
