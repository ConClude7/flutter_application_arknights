import 'package:flutter/material.dart';
import 'package:vector_math/vector_math.dart' as vector;

class ThreeDCard extends StatelessWidget {
  final Widget child;
  final double elevation;
  final double rotateX;
  final double rotateY;

  const ThreeDCard({
    Key? key,
    required this.child,
    this.elevation = 4,
    this.rotateX = 0,
    this.rotateY = 0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Transform(
      transform: _getTransformMatrix(),
      alignment: FractionalOffset.center,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              offset: const Offset(0, 3),
              blurRadius: elevation,
            ),
          ],
        ),
        child: child,
      ),
    );
  }

  Matrix4 _getTransformMatrix() {
    final mat = Matrix4.identity()
      ..setEntry(3, 2, 0.001)
      ..rotateX(vector.radians(rotateX))
      ..rotateY(vector.radians(rotateY));
    return mat;
  }
}
