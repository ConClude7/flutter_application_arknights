import 'dart:math';
import 'dart:ui';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:particles_flutter/component/painter.dart';
import 'package:particles_flutter/particles_flutter.dart';

import '../../common/shared.dart';
import '../../net/httpServe.dart';
import '../../widgets/3dCard.dart';

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
    /* var data = await DartHttpUtils()
        .getDio('/api/users', {"userId": "123456789qwer"}, context);
    print(data); */
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
                child: Stack(
                  children: [
                    Positioned(
                        child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 15.sp),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Text(
                                "Jhin",
                                style: TextStyle(
                                    fontSize: 25.sp,
                                    color: const Color.fromARGB(
                                        200, 229, 229, 229)),
                              ),
                              Text(
                                "No:80797697",
                                style: TextStyle(
                                    fontSize: 10.sp,
                                    color: const Color.fromARGB(
                                        170, 252, 163, 17)),
                              ),
                            ],
                          ),
                          Text(
                            "    这个舞台被我踩在了脚下，但我也把他带到了新的高度。",
                            style: TextStyle(
                              fontSize: 15.sp,
                              fontFamily: "SourceHanSans",
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Text(
                                "入职时间：2023年4月21日",
                                style: TextStyle(
                                    fontSize: 12.sp,
                                    fontFamily: "SourceHanSans",
                                    color: const Color.fromARGB(
                                        100, 229, 229, 229)),
                              )
                            ],
                          ),
                        ],
                      ),
                    ))
                  ],
                )),
          ),
        ),
        /*  ThreeDCard(
          elevation: 10,
          rotateX: 5,
          rotateY: 20,
          child: Container(
            width: 200,
            height: 200,
            color: Colors.blue,
            child: Text(
              'Hello, World!',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ), */
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
      ..color = const Color.fromARGB(170, 252, 163, 17)
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
