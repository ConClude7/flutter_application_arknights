import 'package:flutter/material.dart';
import 'package:flutter_application_arknights/widgets/homeCard.dart';
import 'package:flutter_application_arknights/widgets/homeSwiper.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
      child: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            expandedHeight: 150.sp,
            flexibleSpace: const FlexibleSpaceBar(background: homeSwiper()),
            floating: true,
            pinned: false,
            snap: false,
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              List.generate(
                  50,
                  (index) => Container(
                        width: double.infinity,
                        height: 100.sp,
                        padding: EdgeInsets.symmetric(horizontal: 25.sp),
                        margin: EdgeInsets.only(top: 10.sp, bottom: 10.sp),
                        /* color: Colors.white, */
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Dr.RaBBit@$index"),
                                  SizedBox(
                                      width: double.infinity,
                                      height: 2.sp,
                                      child: GradientLine(
                                        color: Colors.white,
                                      )),
                                ],
                              )
                            ]),
                      )),
            ),
          ),
        ],
      ),
    );
  }
}
