import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_arknights/widgets/indexPages/homeSwiper.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loader_skeleton/loader_skeleton.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);

/*   late Future<Article> _futureArticle; */

  void _onRefresh() async {
    // monitor network fetch
    await Future.delayed(const Duration(milliseconds: 1000));
    // if failed,use refreshFailed()
    _refreshController.refreshCompleted();
  }

  void _onLoading() async {
    /* _futureArticle = getArticles(); */
    // monitor network fetch
    await Future.delayed(const Duration(milliseconds: 1000));
    // if failed,use loadFailed(),if no data return,use LoadNodata()
    if (mounted) setState(() {});
    _refreshController.loadComplete();
  }

  /*  Future<Article> getArticles() async {
     var articles = await DartHttpUtils().getDio('api/articles', context);
    return Article.fromJson(articles);
    return ;
  } */

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.transparent,
        child: FutureBuilder(
          /*   future: _futureArticle, */
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              /*  Article article = snapshot.data!; */
              return SmartRefresher(
                controller: _refreshController,
                enablePullDown: true,
                enablePullUp: true,
                onRefresh: _onRefresh,
                onLoading: _onLoading,
                header: const WaterDropMaterialHeader(),
                footer: smartFooter,
                child: CustomScrollView(
                  physics: const BouncingScrollPhysics(),
                  slivers: <Widget>[
                    SliverAppBar(
                      expandedHeight: 250.sp,
                      flexibleSpace:
                          const FlexibleSpaceBar(background: HomeSwiper()),
                      floating: false,
                      pinned: false,
                      snap: false,
                    ),
                    SliverList(
                      delegate: SliverChildListDelegate(
                        List.generate(
                            10,
                            (index) => /* articleCard(index: index) */
                                Container()),
                      ),
                    ),
                  ],
                ),
              );
            } else if (snapshot.hasError) {
              return Text("${snapshot.error}");
            }
            //等待进度条.
            return DarkCardPageSkeleton(
              totalLines: 6,
            );
          },
          future: null,
        ));
  }
}

// 上拉刷新
CustomFooter smartFooter = CustomFooter(
  loadStyle: LoadStyle.ShowWhenLoading,
  builder: (context, mode) {
    Widget body;
    if (mode == LoadStatus.idle) {
      body = const Text("上拉加载");
    } else if (mode == LoadStatus.loading) {
      body = const CupertinoActivityIndicator();
    } else if (mode == LoadStatus.failed) {
      body = const Text("加载失败！点击重试！");
    } else if (mode == LoadStatus.canLoading) {
      body = const Text("松手,加载更多!");
    } else {
      body = const Text("没有更多数据了!");
    }
    return SizedBox(
      height: 55.0,
      child: Center(child: body),
    );
  },
);
