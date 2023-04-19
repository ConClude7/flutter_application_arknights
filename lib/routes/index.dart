import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:bubble_bottom_bar/bubble_bottom_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../widgets/bubbleBottomItem.dart';
import './home/favoritePage.dart';
import './home/homePage.dart';
import './home/myPage.dart';
import './home/simPage.dart';

class index extends StatefulWidget {
  const index({super.key});

  @override
  State<index> createState() => _indexState();
}

class _indexState extends State<index> {
  late int currentIndex;
  late Widget whatPage;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    currentIndex = 0;
    whatPage = homePage();
  }

  void changePage(int? index) {
    setState(() {
      currentIndex = index!;
      switch (currentIndex) {
        case 0:
          whatPage = homePage();
          break;
        case 1:
          whatPage = simPage();
          break;
        case 2:
          whatPage = favoritePage();
          break;
        case 3:
          whatPage = myPage();
          break;
        default:
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /* appBar: AppBar(), */
      bottomNavigationBar: BubbleBottomBar(
        backgroundColor: const Color.fromARGB(255, 20, 33, 61),
        hasNotch: true,
        opacity: .2,
        currentIndex: currentIndex,
        onTap: changePage,
        elevation: 2,
        tilesPadding: EdgeInsets.symmetric(
          vertical: 8.sp,
        ),
        items: <BubbleBottomBarItem>[
          BubbleItem(
              Icons.houseboat_rounded,
              const Color.fromARGB(255, 229, 229, 229),
              const Color.fromARGB(255, 252, 163, 17),
              const Color.fromARGB(255, 67, 127, 151),
              "首页"),
          BubbleItem(
              Icons.directions_boat,
              const Color.fromARGB(255, 229, 229, 229),
              const Color.fromARGB(255, 252, 163, 17),
              const Color.fromARGB(255, 67, 127, 151),
              "模拟"),
          BubbleItem(
              Icons.water,
              const Color.fromARGB(255, 229, 229, 229),
              const Color.fromARGB(255, 252, 163, 17),
              const Color.fromARGB(255, 67, 127, 151),
              "收藏"),
          BubbleItem(
              Icons.surfing,
              const Color.fromARGB(255, 229, 229, 229),
              const Color.fromARGB(255, 252, 163, 17),
              const Color.fromARGB(255, 67, 127, 151),
              "个人档案"),
        ],
      ),
      body: Container(
          width: double.infinity,
          height: double.infinity,
          color: const Color.fromARGB(255, 52, 52, 52),
          child: CustomPaint(
            painter: _BackgroundPainter(),
            child: whatPage,
          )),
    );
  }
}

class _BackgroundPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final pointRadius = 2.sp;
    final points = <Offset>[];

    // Create a list of random points
    for (double y = 0; y < size.height; y += 10) {
      for (double x = 0; x < size.width; x += 10) {
        points.add(Offset(x, y));
      }
    }

    // Draw the points on the canvas
    canvas.drawPoints(
        PointMode.points,
        points,
        Paint()
          ..isAntiAlias = true
          ..color = const Color.fromARGB(20, 229, 229, 229)
          ..strokeCap = StrokeCap.round
          ..strokeWidth = pointRadius);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
