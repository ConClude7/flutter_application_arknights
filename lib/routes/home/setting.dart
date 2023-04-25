import 'package:flutter/material.dart';
import 'package:flutter_application_arknights/common/shared.dart';
import 'package:flutter_application_arknights/routes/home/myPage.dart';
import 'package:flutter_application_arknights/routes/index.dart';
import 'package:flutter_application_arknights/routes/pages/article.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:getwidget/getwidget.dart';
import '../../widgets/pageAnimation.dart';

import '../../widgets/3dCard.dart';

class settingCards extends StatefulWidget {
  const settingCards({super.key});

  @override
  State<settingCards> createState() => _settingCardsState();
}

class _settingCardsState extends State<settingCards> {
  @override
  Widget build(BuildContext context) {
    return Wrap(
      direction: Axis.horizontal,
      alignment: WrapAlignment.spaceBetween,
      runAlignment: WrapAlignment.start,
      spacing: 10.sp,
      runSpacing: 5.sp,
      children: [
        settingCardBuild(
          width: 175.sp,
          height: 60.sp,
          icon: Icons.document_scanner,
          title: "发表文章",
          onTap: () {
            Navigator.push(
                context,
                EnterExitRoute(
                    exitPage: const index(
                      settingPage: true,
                    ),
                    enterPage: const articlePage()));
          },
        ),
        settingCardBuild(
          width: 175.sp,
          height: 60.sp,
          rotateY: 15.sp,
          icon: Icons.edit,
          title: "文章管理",
          onTap: () {},
        ),
        settingCardBuild(
          width: 150.sp,
          height: 60.sp,
          icon: Icons.bug_report,
          title: "上报Bug",
          onTap: () {},
        ),
        settingCardBuild(
          rotateY: 15,
          width: 200.sp,
          height: 60.sp,
          icon: Icons.follow_the_signs,
          title:
              // ignore: unnecessary_null_comparison
              PersistentStorage().getStorage("token") == null ? "立即登录" : "退出登录",
          onTap: () {
            PersistentStorage().removeStorage("token");
            GFToast.showToast("退出成功", context,
                toastPosition: GFToastPosition.BOTTOM,
                toastBorderRadius: 1.sp,
                /* backgroundColor: const Color.fromARGB(200, 20, 31, 61), */
                /* border: Border.all(width: 1.sp, color: Colors.white38), */
                textStyle: TextStyle(
                  color: const Color.fromARGB(255, 252, 163, 17),
                  fontFamily: "SourceHanSans",
                  fontSize: 15.sp,
                ));

            Navigator.pushNamedAndRemoveUntil(
              context,
              '/login',
              (route) => false,
            );
          },
        )

        /* Transform.scale(
                    scaleX: PersistentStorage().getStorage("token") == null
                        ? -1
                        : 1,
                    child: Icon(
                      Icons.follow_the_signs,
                      size: 50.sp,
                      color: const Color.fromARGB(100, 52, 52, 52),
                    )) */
      ],
    );
  }
}

class settingCardBuild extends StatelessWidget {
  final double width;
  final double height;
  final double rotateY;
  final IconData icon;
  final String title;
  final void Function() onTap;

  const settingCardBuild(
      {super.key,
      required this.width,
      required this.height,
      this.rotateY = -15,
      required this.icon,
      required this.title,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: ThreeDCard(
          elevation: 1,
          rotateX: 3,
          rotateY: rotateY,
          child: SizedBox(
            width: width,
            height: height,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: double.infinity,
                  child: Text(
                    title,
                    style: TextStyle(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.bold,
                        color: const Color.fromARGB(255, 34, 34, 34)),
                  ),
                ),
                Icon(
                  icon,
                  size: 50.sp,
                  color: const Color.fromARGB(100, 52, 52, 52),
                )
              ],
            ),
          )),
    );
  }
}
