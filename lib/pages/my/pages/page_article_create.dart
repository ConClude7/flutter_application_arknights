import 'package:flutter/material.dart';
import 'package:flutter_application_arknights/common/app_bar.dart';
import 'package:flutter_application_arknights/pages/my/services/service_my_article.dart';
import 'package:flutter_application_arknights/widgets/buttons/button_text.dart';
import 'package:flutter_application_arknights/widgets/textfield/hh_textfield.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class PageArticleCreate extends StatefulHookConsumerWidget {
  const PageArticleCreate({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _PageArticleCreateState();
}

class _PageArticleCreateState extends ConsumerState<PageArticleCreate> {
  @override
  Widget build(BuildContext context) {
    final titleVN = useState('');

    final introVN = useState('');

    final contentVN = useState('');

    return Scaffold(
      appBar: HHAppBar(
        title: '发布文章',
        actions: [HHButtonText(text: '草稿箱', onPressed: () {})],
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: HHTextfield(
              onChanged: (textValue) {
                titleVN.value = textValue;
              },
            ),
          ),
          SliverToBoxAdapter(
            child: HHTextfield(
              onChanged: (textValue) {
                introVN.value = textValue;
              },
            ),
          ),
          SliverToBoxAdapter(
            child: HHTextfield(
              onChanged: (textValue) {
                contentVN.value = textValue;
              },
            ),
          ),
          SliverToBoxAdapter(
            child: HHButtonText(
                text: '发表',
                onPressed: () async {
                  await ServiceMyArticle.createArticle(
                      title: titleVN.value,
                      intro: introVN.value,
                      content: contentVN.value);
                }),
          )
        ],
      ),
    );
  }
}
