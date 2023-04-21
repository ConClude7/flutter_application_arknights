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
    // 查询用户
    var data = await DartHttpUtils()
        .getDio('/api/users', {"userId": "123456789qwer"}, context);
    print(data);
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
        ),
        GestureDetector(
          onTap: () async {},
          child: Container(
            width: 100.sp,
            height: 100.sp,
            color: Colors.white,
            child: Text("登录"),
          ),
        ),
        GestureDetector(
          onTap: () async {
            var state = await PersistentStorage().removeStorage("token");
            print("退出登陆:$state");
          },
          child: Container(
            width: 100.sp,
            height: 100.sp,
            color: Colors.white,
            child: Text("退出登录"),
          ),
        ),
        GestureDetector(
          onTap: () async {
            Navigator.pushNamed(context, '/register');
          },
          child: Container(
            width: 100.sp,
            height: 100.sp,
            color: Colors.white,
            child: Text("注册"),
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
