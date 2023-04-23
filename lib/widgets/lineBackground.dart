import 'package:flutter/material.dart';
import 'package:flutter_particles/particles.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:particles_flutter/particles_flutter.dart';

Widget lineBackground = CircularParticle(
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
  awayAnimationDuration: const Duration(microseconds: 300),
  enableHover: false,
  hoverColor: Colors.white,
  hoverRadius: 90,
  connectDots: true, //not recommended
);

/* Widget lineBackground = Particles(30, const Color.fromARGB(20, 255, 255, 255)); */
