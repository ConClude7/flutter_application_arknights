import 'package:flutter/material.dart';
import 'package:flutter_application_arknights/widgets/common/lineBackground.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:particles_fly/particles_fly.dart';
import '../../widgets/indexPages/bubbleBottomItem.dart';
import 'FavoritePage.dart';
import 'HomePage.dart';
import 'myPage.dart';
import 'simPage.dart';

class Index extends StatefulWidget {
  final bool? settingPage;

  const Index({super.key, this.settingPage = false});

  @override
  State<Index> createState() => _IndexState();
}

class _IndexState extends State<Index> {
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
      whatPage = const MyPage();
      changePage(currentIndex);
    } else {
      currentIndex = 0;
      whatPage = const HomePage();
    }
  }

  void changePage(int? index) {
    setState(() {
      currentIndex = index!;
      switch (currentIndex) {
        case 0:
          whatPage = const HomePage();
          break;
        case 1:
          whatPage = SimPage();
          break;
        case 2:
          whatPage = FavoritePage();
          break;
        case 3:
          whatPage = const MyPage();
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
                    Positioned(child: LineBackground(context)),
                    Positioned(child: whatPage)
                  ],
                )),
          )),
    );
  }
}
