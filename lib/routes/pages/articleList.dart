import 'package:flutter/material.dart';
import 'package:flutter_application_arknights/widgets/common/appBar.dart';
import 'package:flutter_application_arknights/widgets/common/articleCard.dart';
import 'package:flutter_application_arknights/widgets/common/lineBackground.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class articleListPage extends StatefulWidget {
  const articleListPage({super.key});

  @override
  State<articleListPage> createState() => _articleListPageState();
}

class _articleListPageState extends State<articleListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: appBar(context, "我的文章", null),
        body: Container(
          width: double.infinity,
          height: double.infinity,
          color: const Color.fromARGB(255, 52, 52, 52),
          child: CustomPaint(
            painter: BackgroundPainter(),
            child: AnimationLimiter(
                child: ListView.builder(
                    itemCount: 40,
                    itemBuilder: (context, int index) {
                      return AnimationConfiguration.staggeredList(
                          position: index,
                          duration: const Duration(milliseconds: 375),
                          child: SlideAnimation(
                              verticalOffset: 50.0,
                              child: FadeInAnimation(
                                  child: articleCard(index: index))));
                    })),
          ),
        ));
  }
}
