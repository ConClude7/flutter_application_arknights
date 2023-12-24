import 'package:flutter/material.dart';
import 'package:flutter_application_arknights/extension/get_theme_color.dart';
import 'package:flutter_application_arknights/extension/hh_image.dart';
import 'package:flutter_application_arknights/models/model_userinfo.dart';
import 'package:flutter_application_arknights/pages/my/services/service_my.dart';
import 'package:flutter_application_arknights/pages/my/provider/vm_my.dart';
import 'package:flutter_application_arknights/pages/my/widget/button_transform.dart';
import 'package:flutter_application_arknights/router/app_router.dart';
import 'package:flutter_application_arknights/router/router_path.dart';
import 'package:flutter_application_arknights/utils/screen_utils.dart';
import 'package:flutter_application_arknights/utils/storage_util.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class MyPage extends StatefulHookConsumerWidget {
  const MyPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MyPageState();
}

class _MyPageState extends ConsumerState<MyPage> {
  final ScrollController sliverController = ScrollController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    sliverController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ref.watch(myInfoVMProvider).when(
              data: (userInfoModel) {
                return Padding(
                  padding:
                      EdgeInsets.only(left: 16.toW, right: 16.toW, top: 16.toW),
                  child: CustomScrollView(
                    controller: sliverController,
                    slivers: [
                      const SliverAppBar(),
                      SliverToBoxAdapter(
                        child: MyUserCard(
                          userInfo: userInfoModel,
                        ),
                      ),
                      SliverToBoxAdapter(
                        child: Wrap(
                          runSpacing: 10.toH,
                          children: [
                            ButtonMyTransfrom(
                              onPressed: () {
                                HHRouter.push(HHRouterPath.articleCreatePage,
                                    context: context);
                              },
                              text: '发表文章',
                            ),
                            ButtonMyTransfrom(
                              onPressed: () {
                                StorageUtil.remove(StorageKey.token);
                                HHRouter.replace(HHRouterPath.loginPage,
                                    context: context);
                              },
                              text: '退出登录',
                            ),
                            ButtonMyTransfrom(
                              onPressed: () {
                                ServiceMy.deleteMe();
                              },
                              text: '注销账户',
                            ),
                            ButtonMyTransfrom(
                              onPressed: () {
                                HHRouter.push(HHRouterPath.articleMyListPage,
                                    context: context);
                              },
                              text: '我的文章',
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
              error: (error, stackTrace) => Container(),
              loading: () => Container(),
            ));
  }
}

class MyUserCard extends HookConsumerWidget {
  final Userinfo userInfo;
  const MyUserCard({super.key, required this.userInfo});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
      shape: BeveledRectangleBorder(
          side: BorderSide(color: ThemeColor.outline(context))),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10.toW, vertical: 7.toH),
        width: double.infinity,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(userInfo.nickname ?? ''),
            HHImage.avatar(
                width: 70.toW, height: 70.toW, imageUrl: userInfo.avatar),
          ],
        ),
      ),
    );
  }
}
