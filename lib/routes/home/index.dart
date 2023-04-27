import 'package:flutter/material.dart';
import 'package:flutter_application_arknights/widgets/common/lineBackground.dart';
import '../../widgets/common/lineBackground.dart';
import '../../widgets/indexPages/bubbleBottomItem.dart';
import 'favoritePage.dart';
import 'homePage.dart';
import 'myPage.dart';
import 'simPage.dart';

class index extends StatefulWidget {
  final bool? settingPage;

  const index({super.key, this.settingPage = false});

  @override
  State<index> createState() => _indexState();
}

class _indexState extends State<index> {
  late Widget whatPage;
  late int currentIndex;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loading();
  }

  void loading() async {
    if (widget.settingPage!) {
      currentIndex = 3;
      whatPage = const myPage();
      changePage(currentIndex);
    } else {
      currentIndex = 0;
      whatPage = const homePage();
    }
  }

  void changePage(int? index) {
    setState(() {
      currentIndex = index!;
      switch (currentIndex) {
        case 0:
          whatPage = const homePage();
          break;
        case 1:
          whatPage = simPage();
          break;
        case 2:
          whatPage = favoritePage();
          break;
        case 3:
          whatPage = const myPage();
          break;
        default:
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /* appBar: AppBar(), */
      bottomNavigationBar: bottomBar(currentIndex, changePage),
      body: Container(
          width: double.infinity,
          height: double.infinity,
          color: const Color.fromARGB(255, 52, 52, 52),
          child: CustomPaint(
            painter: BackgroundPainter(),
            child: DefaultTextStyle(
                style: const TextStyle(
                    fontFamily: "PlayfairDisplay",
                    color: Color.fromARGB(255, 229, 229, 229)),
                child: Stack(
                  children: [
                    Positioned(child: lineBackground),
                    Positioned(child: whatPage)
                  ],
                )),
          )),
    );
  }
}
