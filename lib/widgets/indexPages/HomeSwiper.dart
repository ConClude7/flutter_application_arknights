import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:flutter_swiper_null_safety/flutter_swiper_null_safety.dart';

class HomeSwiper extends StatefulWidget {
  const HomeSwiper({super.key});

  @override
  State<HomeSwiper> createState() => _HomeSwiperState();
}

class _HomeSwiperState extends State<HomeSwiper> {
  int pageIndex = 0;
  List images = const [
    "http://img.pconline.com.cn/images/upload/upc/tx/photoblog/1208/19/c10/13040411_13040411_1345389063185.jpg",
    "http://img.pconline.com.cn/images/upload/upc/tx/photoblog/1208/19/c10/13040411_13040411_1345389069597.jpg",
    "http://img.pconline.com.cn/images/upload/upc/tx/photoblog/1208/19/c10/13040535_13040535_1345389344779.jpg",
    "http://img.pconline.com.cn/images/upload/upc/tx/photoblog/1208/19/c10/13040685_13040685_1345389642926.jpg",
    "http://img.pconline.com.cn/images/upload/upc/tx/photoblog/1208/19/c10/13040828_13040828_1345390015545.jpg",
  ];

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Swiper(
          curve: Curves.easeInOut,
          autoplay: true,
          autoplayDelay: 5000,
          viewportFraction: 1,
          scale: 1,
          itemBuilder: (BuildContext context, int index) {
            return Image.network(
              images[index],
              fit: BoxFit.fill,
            );
          },
          itemCount: images.length,
          control: null,
          pagination: null,
          onIndexChanged: (index) {
            setState(() {
              pageIndex = index;
            });
          },
        ),
        Positioned(
          bottom: 0,
          child: Padding(
            padding: const EdgeInsets.all(2),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(images.length, (index) {
                return Container(
                  height: 2,
                  width: 10,
                  margin: const EdgeInsets.only(left: 4, right: 4),
                  decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(0)),
                      color: (index == (pageIndex % images.length))
                          ? Colors.white
                          : const Color.fromRGBO(180, 180, 180, 0.6)),
                );
              }),
            ),
          ),
        )
      ],
    );
  }
}




/* Yhh_Swiper(
            width: 300.sp,
            height: 117.sp,
            align: Alignment.bottomRight,
            onTap: [
              () {
                print("跳转1");
              },
              () {
                print("跳转2");
              },
              () {
                print("跳转3");
              },
              () {
                print("跳转4");
              },
              () {
                print("跳转5");
              },
            ],
            images: const [
              DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(
                      "http://img.pconline.com.cn/images/upload/upc/tx/photoblog/1208/19/c10/13040411_13040411_1345389063185.jpg")),
              DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(
                      "http://img.pconline.com.cn/images/upload/upc/tx/photoblog/1208/19/c10/13040411_13040411_1345389069597.jpg")),
              DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(
                      "http://img.pconline.com.cn/images/upload/upc/tx/photoblog/1208/19/c10/13040535_13040535_1345389344779.jpg")),
              DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(
                      "http://img.pconline.com.cn/images/upload/upc/tx/photoblog/1208/19/c10/13040685_13040685_1345389642926.jpg")),
              DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(
                      "http://img.pconline.com.cn/images/upload/upc/tx/photoblog/1208/19/c10/13040828_13040828_1345390015545.jpg")),
            ],
          ), */