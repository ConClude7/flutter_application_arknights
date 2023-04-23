import 'dart:async';
import 'package:flutter/material.dart';

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
      this.borderRadius = const BorderRadius.all(Radius.circular(8)),
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
      borderRadius: widget.borderRadius,
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
