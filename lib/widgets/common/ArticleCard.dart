import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_application_arknights/models/article.dart';
import 'package:flutter_application_arknights/net/httpServe.dart';
import 'package:flutter_application_arknights/widgets/yhhElement.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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

  const ArticleCard({Key? key, required this.article, required this.firstIndex})
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
    _futureImages = getImagesBase64();
  }

  Future<List<dynamic>> getImagesBase64() async {
    final res = await DartHttpUtils().postJsonDio(
        "/api/articles/getImages", {"images": widget.article.images}, context);
    if (res != null) {
      return res;
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
              onTap: () {
                print("article.id: ${widget.article.id}");
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
                          final List<dynamic> imagesBase64 = snapshot.data!;
                          return Yhh_ImageShow(
                              base64: imagesBase64,
                              firstIndex: widget.firstIndex);
                        } else if (snapshot.hasError) {
                          return Text("${snapshot.error}");
                        } else {
                          return const CircularProgressIndicator();
                        }
                      },
                    ),
            )
          ],
        ),
      ),
    );
  }
}
