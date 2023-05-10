import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:particles_fly/particles_fly.dart';

// ignore: non_constant_identifier_names
LineBackground(context) {
  return ParticlesFly(
    width: MediaQuery.of(context).size.width,
    height: MediaQuery.of(context).size.height,
    numberOfParticles: 12,
    connectDots: true,
    onTapAnimation: false,
    speedOfParticles: 1,
    particleColor: const Color.fromARGB(30, 255, 255, 255),
    lineColor: const Color.fromARGB(20, 255, 255, 255),
    isRandSize: true,
    maxParticleSize: 3,
  );
}

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
