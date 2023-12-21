import 'package:flutter/material.dart';
import 'package:flutter_application_arknights/common/static/animation_duration.dart';
import 'package:flutter_application_arknights/extension/get_theme_color.dart';
import 'package:flutter_application_arknights/extension/hh_image.dart';
import 'package:flutter_application_arknights/models/index.dart';
import 'package:flutter_application_arknights/providers/provider_myinfo.dart';
import 'package:flutter_application_arknights/router/router_path.dart';
import 'package:flutter_application_arknights/utils/screen_utils.dart';
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

    Future.delayed(HHDuration.longAnimated, () {
      final UserInfo userInfo = UserInfo();
      userInfo.username = 'Jhin';
      userInfo.avatar = 'https://s2.loli.net/2023/12/12/xEFqRZAru7UPMS6.jpg';
      ref.read(myUserInfoProvider.notifier).changeInfo(newInfo: userInfo);
    });
  }

  @override
  Widget build(BuildContext context) {
    final UserInfo? userInfo =
        ref.watch(myUserInfoProvider.select((value) => value.userInfo));
    return userInfo == null
        ? const SizedBox.shrink()
        : Scaffold(
            body: Padding(
              padding:
                  EdgeInsets.only(left: 16.toW, right: 16.toW, top: 16.toW),
              child: CustomScrollView(
                controller: sliverController,
                slivers: [
                  const SliverAppBar(),
                  SliverToBoxAdapter(
                    child: MyUserCard(
                      userInfo: userInfo,
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: MaterialButton(
                      onPressed: () {
                        Navigator.pushNamed(context, HHRouterPath.loginPage);
                      },
                      child: const Text('退出登录'),
                    ),
                  ),
                ],
              ),
            ),
          );
  }
}

class MyUserCard extends HookConsumerWidget {
  final UserInfo userInfo;
  const MyUserCard({super.key, required this.userInfo});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bool userInitState = userInfo.username.isNotEmpty;
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
            Visibility(visible: userInitState, child: Text(userInfo.username)),
            HHImage.avatar(
                width: 70.toW, height: 70.toW, imageUrl: userInfo.avatar),
          ],
        ),
      ),
    );
  }
}
