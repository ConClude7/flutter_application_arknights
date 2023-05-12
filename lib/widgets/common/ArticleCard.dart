import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_application_arknights/common/shared.dart';
import 'package:flutter_application_arknights/models/article.dart';
import 'package:flutter_application_arknights/net/httpServe.dart';
import 'package:flutter_application_arknights/widgets/common/MyToast.dart';
import 'package:flutter_application_arknights/widgets/function/imageUrl.dart';
import 'package:flutter_application_arknights/widgets/yhhElement.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:getwidget/getwidget.dart';
import 'package:pull_down_button/pull_down_button.dart';

class GradientLine extends StatelessWidget {
  final double height;
  final Color color;
  final double maxOpacity;

  const GradientLine({
    super.key,
    this.height = 1.0,
    this.color = Colors.black,
    this.maxOpacity = 0.4,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          stops: _generateStops(),
          colors: _generateColors(),
        ),
      ),
    );
  }

  List<double> _generateStops() {
    Random random = Random();
    double randomStop = random.nextDouble();
    return [0.0, randomStop, 1.0];
  }

  List<Color> _generateColors() {
    List<Color> colors = [
      color.withOpacity(1.0),
      color.withOpacity(maxOpacity),
      color.withOpacity(0.0),
    ];
    return colors;
  }
}

class ArticleCard extends StatefulWidget {
  final Article article;
  final int firstIndex;
  final bool author;

  const ArticleCard(
      {Key? key,
      required this.article,
      required this.firstIndex,
      this.author = false})
      : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _ArticleCardState createState() => _ArticleCardState();
}

class _ArticleCardState extends State<ArticleCard> {
  late Future<List<dynamic>> _futureImages;

  @override
  void initState() {
    super.initState();
    _futureImages = getImagesUrl();
  }

  Future<List<dynamic>> getImagesUrl() async {
    final res = await DartHttpUtils().postJsonDio("/api/articles/getImages",
        {"images": widget.article.images, "compress": true}, context);
    if (res != null) {
      return imagesUrl(res);
    } else {
      throw Exception('Failed to load images');
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTextStyle(
      style: TextStyle(
        fontFamily: "PlayfairDisplay",
        fontSize: 25.sp,
        color: const Color.fromARGB(255, 229, 229, 229),
      ),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 25.sp),
        margin: EdgeInsets.symmetric(vertical: 20.sp),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            GestureDetector(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.article.title,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 30.sp,
                    ),
                  ),
                  SizedBox(
                    width: double.infinity,
                    height: 2.sp,
                    child: const GradientLine(
                      color: Colors.white,
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(horizontal: 10.sp),
                    child: Text(
                      widget.article.content,
                      softWrap: true,
                      textAlign: TextAlign.left,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 4,
                    ),
                  ),
                ],
              ),
              onTap: () async {
                print("article.id: ${widget.article.id}");
                var res = await DartHttpUtils()
                    .deleteDio("/api/articles/${widget.article.id}", context);
                if (res['status']) {
                  MyToast.success(context, "删除成功", null);
                }
              },
            ),
            SizedBox(
              height: 30.sp,
            ),
            SizedBox(
              child: widget.article.images.isEmpty
                  ? const SizedBox.shrink()
                  : FutureBuilder(
                      future: _futureImages,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          final List<dynamic> imagesUrl = snapshot.data!;

                          return Yhh_ImageShow(
                              imagesUrl: imagesUrl,
                              imageNames: widget.article.images,
                              firstIndex: widget.firstIndex);
                        } else if (snapshot.hasError) {
                          return Text("${snapshot.error}");
                        } else {
                          return const CircularProgressIndicator();
                        }
                      },
                    ),
            ),
            widget.author
                ? Container(
                    width: double.infinity,
                    alignment: Alignment.centerRight,
                    child: Theme(
                        data: ThemeData.dark(),
                        child: PullDownButton(
                          itemBuilder: (context) => [
                            PullDownMenuActionsRow.medium(
                                items: [
                              [
                                "修改",
                                () {
                                  print("修改");
                                },
                                Icons.tab
                              ],
                              [
                                "删除",
                                () {
                                  print("删除");
                                },
                                Icons.tab
                              ]
                            ]
                                    .map((List<dynamic> value) =>
                                        PullDownMenuItem(
                                          onTap: value[1],
                                          title: value[0],
                                          icon: value[2],
                                        ))
                                    .toList())
                          ],
                          buttonBuilder: (BuildContext context,
                              Future<void> Function() showMenu) {
                            return HappyIcon();
                          },
                        )))
                : const SizedBox.shrink(),
          ],
        ),
      ),
    );
  }
}

/* Widget DropDowmButton = PullDownButton(
  itemBuilder: (context) => [
    PullDownMenuActionsRow.medium(
        items: [
      [
        "修改",
        () {
          print("修改");
        },
        Icons.tab
      ],
      [
        "删除",
        () {
          print("删除");
        },
        Icons.tab
      ]
    ]
            .map((List<dynamic> value) => PullDownMenuItem(
                  onTap: value[1],
                  title: value[0],
                  icon: value[2],
                ))
            .toList())
  ],
  buttonBuilder: (BuildContext context, Future<void> Function() showMenu) {
    return IconButton(
        onPressed: showMenu,
        icon: const Icon(
          Icons.keyboard_command_key,
          size: 10,
        ));
  },
); */

class HappyIcon extends StatefulWidget {
  @override
  _HappyIconState createState() => _HappyIconState();
}

class _HappyIconState extends State<HappyIcon>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void startRotationAnimation() {
    _animationController.reset();
    _animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return Transform.rotate(
          angle:
              _animationController.value * 2.0 * 3.141592653589793, // 旋转角度为0到2π
          child: IconButton(
            onPressed: () {
              startRotationAnimation();
            },
            icon: const Icon(
              Icons.keyboard_command_key,
              size: 35.0,
              color: Colors.orange,
            ),
          ),
        );
      },
    );
  }
}
