import 'package:flutter_application_arknights/models/model_article.dart';
import 'package:flutter_application_arknights/net/http_utils.dart';
import 'package:flutter_application_arknights/utils/data_list.util.dart';
import 'package:flutter_application_arknights/utils/loading_utils.dart';
import 'package:flutter_application_arknights/utils/logger.dart';

class ServiceMyArticle {
  static Future<void> createArticle(
      {required String title,
      required String intro,
      required String content}) async {
    await HHDio().post(path: 'article/', params: {
      "title": title,
      "intro": intro,
      "content": content,
    });
  }

  static Future<List<Article>> getMyArticles() async {
    late final List<Article> articleList;
    await HHDio().get(
      path: 'article',
      params: {
        "pageIndex": 0,
        "pageSize": 5,
      },
      successCallback: (data) {
        final getArticleList = HHDataList<Article>(data)
            .getListModel((json) => Article.fromMap(json));
        logPrint(getArticleList.first.toString());
        articleList = getArticleList;
      },
    );
    return articleList;
  }

  static Future<bool> deleteArticle({required String articleId}) async {
    bool state = false;
    await HHDio().delete(
      path: 'article',
      params: {
        "articleId": articleId,
      },
      successCallback: (data) {
        state = true;
        HHLoading.showSuccess(msg: '删除成功');
      },
      errorCallback: (error) {
        HHLoading.showError(msg: error.message ?? '');
      },
    );
    return state;
  }
}
