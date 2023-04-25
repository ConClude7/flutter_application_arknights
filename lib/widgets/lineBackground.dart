import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_particles/particles.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:particles_flutter/particles_flutter.dart';

/* Widget lineBackground = CircularParticle(
  key: UniqueKey(),
  awayRadius: 100,
  numberOfParticles: 100,
  speedOfParticles: 0.8,
  height: 892.sp,
  width: 412.sp,
  onTapAnimation: false,
  particleColor: const Color.fromARGB(20, 255, 255, 255),
  maxParticleSize: 2,
  isRandSize: true,
  isRandomColor: false,
  awayAnimationCurve: Curves.fastOutSlowIn,
  awayAnimationDuration: const Duration(milliseconds: 300),
  enableHover: false,
  hoverColor: Colors.white,
  hoverRadius: 90,
  connectDots: true, //not recommended
); */

Widget lineBackground = Particles(20, const Color.fromARGB(20, 255, 255, 255));

class BackgroundPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final pointRadius = 2.sp;
    final points = <Offset>[];

    // Create a list of random points
    for (double y = 0; y < size.height; y += 10) {
      for (double x = 0; x < size.width; x += 9) {
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
