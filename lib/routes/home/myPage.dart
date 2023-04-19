import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class myPage extends StatefulWidget {
  const myPage({super.key});

  @override
  State<myPage> createState() => _myPageState();
}

class _myPageState extends State<myPage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 15.sp),
          margin: EdgeInsets.only(top: 40.sp, bottom: 20.sp),
          child: Container(
            clipBehavior: Clip.hardEdge,
            width: double.infinity,
            height: 100.sp,
            decoration: BoxDecoration(
                color: const Color.fromARGB(50, 255, 255, 255),
                borderRadius: BorderRadius.all(Radius.circular(8.sp))),
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
