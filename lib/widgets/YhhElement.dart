import 'dart:async';
import 'dart:convert';
import 'package:dismissible_page/dismissible_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_arknights/net/httpServe.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'common/PhotoShow.dart';

class Yhh_Swiper extends StatefulWidget {
  // 滑动方向
  final Axis? direction;
  // 宽
  final double width;
  // 高
  final double height;
  // 圆角
  final BorderRadius? borderRadius;
  // 进度条位置
  final AlignmentGeometry? align;
  // 点击事件
  final List<void Function()> onTap;
  // 图片库
  final List<DecorationImage> images;

  const Yhh_Swiper(
      {super.key,
      required this.width,
      required this.height,
      required this.onTap,
      required this.borderRadius,
      required this.images,
      this.align = Alignment.bottomCenter,
      this.direction = Axis.horizontal});

  @override
  State<Yhh_Swiper> createState() => _Yhh_SwiperState();
}

class _Yhh_SwiperState extends State<Yhh_Swiper> {
  late PageController pageController;
  late int pageIndex;

  @override
  void initState() {
    pageIndex = widget.images.length * 100;
    super.initState();
    pageController = PageController(
        initialPage: widget.images.length * 100,
        keepPage: true,
        viewportFraction: 1);

    timer();
  }

  void timer() {
    Timer.periodic(const Duration(milliseconds: 3000), (timer) {
      pageController.animateToPage(pageIndex++,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOutSine);
    });
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> pageList = widget.images.map((image) {
      return GestureDetector(
        onTap: widget.onTap[pageIndex % widget.images.length],
        child: Container(
          decoration: BoxDecoration(
            image: image,
          ),
        ),
      );
    }).toList();
    return ClipRRect(
      borderRadius:
          widget.borderRadius ?? BorderRadius.all(Radius.circular(8.sp)),
      child: SizedBox(
        width: widget.width,
        height: widget.height,
        child: Stack(
          alignment: widget.align!,
          children: [
            // 图片区域
            Positioned(
              child: PageView.builder(
                  controller: pageController,
                  scrollDirection: widget.direction!,
                  // 头尾滑动超出动画
                  physics: const BouncingScrollPhysics(),
                  onPageChanged: (value) {
                    setState(() {
                      pageIndex = value;
                    });
                  },
                  itemBuilder: (context, index) {
                    return pageList[index % widget.images.length];
                  }),
            ),
            // 轮播图进度点
            Positioned(
              right: 0,
              child: Padding(
                padding: const EdgeInsets.all(2),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(widget.images.length, (index) {
                    return Container(
                      height: 2,
                      width: 10,
                      margin: const EdgeInsets.only(left: 4, right: 4),
                      decoration: BoxDecoration(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(3)),
                          color: (index == (pageIndex % widget.images.length))
                              ? Colors.white
                              : const Color.fromRGBO(180, 180, 180, 0.6)),
                    );
                  }),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class Yhh_ImageShow extends StatefulWidget {
  final List<dynamic> imagesUrl;
  final List<dynamic> imageNames;
  final int firstIndex;

  const Yhh_ImageShow({
    super.key,
    required this.imagesUrl,
    required this.imageNames,
    required this.firstIndex,
  });

  @override
  State<Yhh_ImageShow> createState() => _Yhh_ImageShowState();
}

class _Yhh_ImageShowState extends State<Yhh_ImageShow> {
  @override
  Widget build(BuildContext context) {
    final showIndex =
        widget.imagesUrl.length <= 3 ? widget.imagesUrl.length : 3;
    final moreIndex = widget.imagesUrl.length - 3;
    final imageWidth =
        (MediaQuery.of(context).size.width - 50.sp) / showIndex - 5.sp;
    final borderRadius = showIndex == -3 ? 0.sp : 10.sp;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: List.generate(showIndex, (index) {
        final tagName = "Tag${widget.firstIndex}$index";
        return GestureDetector(
          child: Stack(
            alignment: Alignment.center,
            children: [
              Container(
                  width: moreIndex == -2 ? 200.sp : imageWidth,
                  height: moreIndex == -2 ? 400.sp : imageWidth,
                  clipBehavior: Clip.hardEdge,
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(borderRadius),
                        bottomLeft: Radius.circular(borderRadius),
                        bottomRight: Radius.circular(borderRadius)),
                  ),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Positioned(
                          child: SizedBox(
                        width: double.infinity,
                        height: double.infinity,
                        child: Hero(
                            tag: tagName,
                            child: Image.network(
                              widget.imagesUrl[index],
                              fit: BoxFit.cover,
                            )),
                      )),
                      Positioned(
                          bottom: 5.sp,
                          right: 5.sp,
                          child: (index != 2 || moreIndex <= 0)
                              ? const SizedBox.shrink()
                              : Container(
                                  width: 40.sp,
                                  height: 30.sp,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      color: Colors.black54,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(30.sp))),
                                  child: Text(
                                    "+$moreIndex",
                                    style: TextStyle(fontSize: 18.sp),
                                  ),
                                ))
                    ],
                  )),
            ],
          ),
          onTap: () {
            // ignore: use_build_context_synchronously
            context.pushTransparentRoute(PhotoShow(
              tagName: tagName,
              imageNames: widget.imageNames,
              iamgeIndex: index,
            ));
          },
        );
      }),
    );
  }
}
