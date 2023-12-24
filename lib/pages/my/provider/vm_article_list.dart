import 'package:flutter_application_arknights/models/model_article.dart';
import 'package:flutter_application_arknights/pages/my/services/service_my_article.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'vm_article_list.g.dart';

@riverpod
class MyArticleListVM extends _$MyArticleListVM {
  @override
  Future<List<Article>> build() async {
    final List<Article> articleList = await ServiceMyArticle.getMyArticles();
    return articleList;
  }

  Future<void> deleteArticle({required String articleId}) async {
    final deleteState =
        await ServiceMyArticle.deleteArticle(articleId: articleId);
    if (deleteState) {
      final articleList = await future;
      articleList.removeWhere((element) => element.articleId == articleId);
      state = AsyncData(articleList);
    }
  }
}
