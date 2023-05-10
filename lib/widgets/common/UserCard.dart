import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget UserCard(pagePadding, user) {
  return Container(
    width: double.infinity,
    padding: pagePadding,
    margin: EdgeInsets.only(top: 50.sp),
    child: Container(
      clipBehavior: Clip.hardEdge,
      width: double.infinity,
      decoration: BoxDecoration(
          color: const Color.fromARGB(100, 34, 34, 34),
          borderRadius: BorderRadius.all(Radius.circular(2.sp)),
          border: Border.all(
              color: const Color.fromARGB(255, 255, 255, 255),
              width: 1.sp,
              style: BorderStyle.solid,
              strokeAlign: BorderSide.strokeAlignInside)),
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
                          user.username,
                          style: TextStyle(
                              fontSize: 50.sp,
                              color: const Color.fromARGB(200, 229, 229, 229)),
                        ),
                        Text(
                          "No.   ",
                          style: TextStyle(
                              fontSize: 20.sp,
                              color: const Color.fromARGB(170, 252, 163, 17)),
                        ),
                      ],
                    ),
                    Container(
                      margin: EdgeInsets.only(bottom: 40.sp),
                      child: Text(
                        "    ${user.says}",
                        style: TextStyle(
                          fontSize: 30.sp,
                          fontFamily: "SourceHanSans",
                        ),
                      ),
                    )
                  ],
                ),
              )),
              Positioned(
                bottom: 5.sp,
                right: 20.sp,
                child: Text(
                  "入职时间：${user.created.substring(0, user.created.indexOf('日'))}",
                  style: TextStyle(
                      fontSize: 24.sp,
                      fontFamily: "SourceHanSans",
                      color: const Color.fromARGB(100, 229, 229, 229)),
                ),
              )
            ],
          )),
    ),
  );
}

class _DiagonalLinesPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color.fromARGB(180, 255, 255, 255)
      ..strokeWidth = 2.sp;

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
      canvas.drawLine(Offset(size.width - (6 * (i + 1)).sp, 0.sp),
          Offset(size.width - (6 * (i + 1)).sp, size.height), paintRight);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
