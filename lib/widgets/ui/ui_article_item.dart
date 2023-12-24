import 'package:flutter_application_arknights/models/model_article.dart';
import 'package:flutter_application_arknights/utils/screen_utils.dart';
import 'package:flutter_application_arknights/utils/time_util.dart';
import 'package:flutter_application_arknights/widgets/buttons/button_text.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter/material.dart';

class UiArticleItem extends HookConsumerWidget {
  final Article article;
  final Function(String articleId) onDelete;

  const UiArticleItem(
      {super.key, required this.article, required this.onDelete});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(10.toW),
      child: Wrap(
        children: [
          Text('title:${article.title}'),
          Text('intro:${article.intro}'),
          Text('content:${article.content}'),
          Text('time:${HHTimeUtil.getYMDHMS(article.createTime)}'),
          HHButtonText(
              text: '删除',
              onPressed: () {
                onDelete(article.articleId ?? '');
              }),
        ],
      ),
    );
  }
}
