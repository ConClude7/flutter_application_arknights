import 'package:flutter/material.dart';

class homePage extends StatefulWidget {
  const homePage({super.key});

  @override
  State<homePage> createState() => _homePageState();
}

class _homePageState extends State<homePage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: Colors.transparent,
      child: const Center(
        child: Text(
          "明日方舟ArkNights",
          style: TextStyle(fontFamily: "PlayfairDisplay"),
        ),
      ),
    );
  }
}
