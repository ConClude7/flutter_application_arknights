import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class GradientLine extends StatelessWidget {
  final double height;
  final Color color;
  final double maxOpacity;

  GradientLine({
    this.height = 1.0,
    this.color = Colors.black,
    this.maxOpacity = 0.5,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          stops: _generateStops(),
          colors: _generateColors(),
        ),
      ),
    );
  }

  List<double> _generateStops() {
    Random random = Random();
    double randomStop = random.nextDouble();
    return [0.0, randomStop, 1.0];
  }

  List<Color> _generateColors() {
    List<Color> colors = [
      color.withOpacity(1.0),
      color.withOpacity(maxOpacity),
      color.withOpacity(0.0),
    ];
    return colors;
  }
}

class articleCard extends StatelessWidget {
  final int index;

  const articleCard({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 175.sp,
      padding: EdgeInsets.symmetric(horizontal: 25.sp),
      margin: EdgeInsets.only(top: 10.sp, bottom: 10.sp),
      /* color: Colors.white, */
      child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Dr.RaBBit@$index",
                  style: const TextStyle(
                      fontFamily: "PlayfairDisplay",
                      color: Color.fromARGB(255, 229, 229, 229)),
                ),
                SizedBox(
                    width: double.infinity,
                    height: 2.sp,
                    child: GradientLine(
                      color: Colors.white,
                    )),
              ],
            )
          ]),
    );
  }
}
