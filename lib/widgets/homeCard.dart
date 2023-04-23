import 'dart:math';
import 'package:flutter/material.dart';

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
