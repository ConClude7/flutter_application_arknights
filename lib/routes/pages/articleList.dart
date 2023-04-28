import 'package:flutter/material.dart';
import 'package:flutter_application_arknights/models/article.dart';
import 'package:flutter_application_arknights/net/httpServe.dart';
import 'package:flutter_application_arknights/widgets/common/appBar.dart';
import 'package:flutter_application_arknights/widgets/common/articleCard.dart';
import 'package:flutter_application_arknights/widgets/common/lineBackground.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:loader_skeleton/loader_skeleton.dart';

class articleListPage extends StatefulWidget {
  const articleListPage({super.key});

  @override
  State<articleListPage> createState() => _articleListPageState();
}

class _articleListPageState extends State<articleListPage> {
  late Future<List<Article>> _futureArticle;

  @override
  void initState() {
    super.initState();
    _futureArticle = getArticles();
  }

  Future<List<Article>> getArticles() async {
    var res =
        await DartHttpUtils().getDio("/api/articles", context) as List<dynamic>;
    final resList = <Article>[];
    for (Map<String, dynamic> data in res) {
      resList.add(Article.fromJson(data));
    }

    return resList;
  }

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
                child: FutureBuilder<List<Article>>(
                  future: _futureArticle,
                  builder: (context, snapshot) {
                    /* print("snapshot:$snapshot"); */
                    if (snapshot.hasData) {
                      List<Article> articles = snapshot.data!;
                      return AnimationLimiter(
                          child: ListView.builder(
                              itemCount: articles.length,
                              itemBuilder: (context, int index) {
                                return AnimationConfiguration.staggeredList(
                                    position: index,
                                    duration: const Duration(milliseconds: 375),
                                    child: SlideAnimation(
                                        verticalOffset: 50.0,
                                        child: FadeInAnimation(
                                            child: articleCard(
                                          article: articles[index],
                                        ))));
                              }));
                    } else if (snapshot.hasError) {
                      return Text("${snapshot.error}");
                    } else {
                      return DarkCardListSkeleton();
                    }
                  },
                ))));
  }
}
