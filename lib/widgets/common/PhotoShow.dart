import 'package:cached_network_image/cached_network_image.dart';
import 'package:dismissible_page/dismissible_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_arknights/net/httpServe.dart';
import 'package:flutter_application_arknights/widgets/common/MyToast.dart';
import 'package:flutter_application_arknights/widgets/common/Refreshing.dart';
import 'package:flutter_application_arknights/widgets/function/imageUrl.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PhotoShow extends StatelessWidget {
  final String tagName;
  final List<dynamic> imageNames;
  final int iamgeIndex;

  const PhotoShow({
    Key? key,
    required this.tagName,
    required this.imageNames,
    required this.iamgeIndex,
  }) : super(key: key);

  Future<List<dynamic>> getFullImages(BuildContext context) async {
    final res = await DartHttpUtils().postJsonDio(
      "/api/articles/getImages",
      {"images": imageNames, "compress": false},
      context,
    );
    return imagesUrl(res);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<dynamic>>(
      future: getFullImages(context),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError) {
            return MyToast.error(context, "获取图片失败", null);
          } else {
            final imagesUrl = snapshot.data;
            final PageController pageController =
                PageController(initialPage: iamgeIndex);
            return DismissiblePage(
              backgroundColor: const Color.fromARGB(255, 52, 52, 52),
              onDismissed: () {
                Navigator.of(context).pop();
              },
              isFullScreen: true,
              child: PageView.builder(
                allowImplicitScrolling: true,
                controller: pageController,
                itemCount: imagesUrl!.length,
                itemBuilder: (context, index) {
                  return Hero(
                      tag: "${tagName.substring(0, tagName.length - 1)}$index",
                      child: CachedNetworkImage(
                        imageUrl: imagesUrl[index],
                      ));
                },
              ),
            );
          }
        } else {
          return SizedBox(
            width: 100.sp,
            height: 100.sp,
            child: RefreshWidget,
          );
        }
      },
    );
  }
}
