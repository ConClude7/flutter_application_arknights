import 'package:flutter/material.dart';
import 'package:flutter_application_arknights/common/app_bar.dart';
import 'package:flutter_application_arknights/pages/my/provider/vm_article_list.dart';
import 'package:flutter_application_arknights/widgets/ui/ui_article_item.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class PageMyArticles extends StatefulHookConsumerWidget {
  const PageMyArticles({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _PageMyArticlesState();
}

class _PageMyArticlesState extends ConsumerState<PageMyArticles> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const HHAppBar(
        title: '我的文章',
      ),
      body: ref.watch(myArticleListVMProvider).when(
            data: (articleListModel) {
              return CustomScrollView(
                slivers: [
                  SliverAnimatedList(
                    initialItemCount: 5,
                    itemBuilder: (context, index, animation) {
                      final article = articleListModel[index];
                      return UiArticleItem(
                        article: article,
                        onDelete: (articleId) {
                          ref
                              .read(myArticleListVMProvider.notifier)
                              .deleteArticle(articleId: articleId);
                        },
                      );
                    },
                  )
                ],
              );
            },
            error: (error, stackTrace) => Container(),
            loading: () => Container(),
          ),
    );
  }
}
