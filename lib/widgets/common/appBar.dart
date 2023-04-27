// ignore: file_names
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:particles_flutter/particles_flutter.dart';

AppBar appBar(BuildContext context, String title, List<Widget>? actions) {
  return AppBar(
    centerTitle: true,
    title: Text(
      title,
      style: const TextStyle(color: Color.fromARGB(255, 229, 229, 229)),
    ),
    leading: IconButton(
        color: const Color.fromARGB(255, 229, 229, 229),
        icon: const Icon(Icons.arrow_back_ios),
        onPressed: () => Navigator.pop(context)),
    actions: actions,
    flexibleSpace: appBarBackground(context),
  );
}

Widget appBarBackground(BuildContext context) {
  return CircularParticle(
    key: UniqueKey(),
    awayRadius: 10,
    numberOfParticles: 15,
    speedOfParticles: 2,
    height: 100.sp,
    width: MediaQuery.of(context).size.width,
    onTapAnimation: false,
    maxParticleSize: 3,
    isRandSize: true,
    isRandomColor: true,
    randColorList: const [
      Color.fromARGB(20, 255, 255, 255),
      Color.fromARGB(20, 0, 0, 0),
      Color.fromARGB(50, 0, 0, 0)
    ],
    awayAnimationCurve: Curves.fastOutSlowIn,
    awayAnimationDuration: const Duration(milliseconds: 1000),
    enableHover: false,
    hoverColor: Colors.white,
    hoverRadius: 0,
    particleColor: const Color.fromARGB(10, 255, 255, 255),
    connectDots: true, //not recommended
  );
}
