import 'package:flutter/material.dart';
import 'package:flutter_application_arknights/pages/home/page_home.dart';
import 'package:flutter_application_arknights/pages/my/page_my.dart';
import 'package:flutter_application_arknights/providers/provider_tabbar.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:stylish_bottom_bar/model/bar_items.dart';
import 'package:stylish_bottom_bar/stylish_bottom_bar.dart';

/// PageView配置
class _TabConfig {
  final Widget page;
  final IconData iconData;
  final String tabName;

  _TabConfig(this.page, this.iconData, this.tabName);
}

class TabbarPage extends ConsumerWidget {
  const TabbarPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final PageController pageController =
        PageController(initialPage: ref.watch(tabbarProvider), keepPage: true);
    final List<_TabConfig> tabConfigs = [
      _TabConfig(const MyHomePage(), Icons.home, '首页'),
      _TabConfig(const MyPage(), Icons.person, '我的'),
    ];

    return DefaultTabController(
        length: tabConfigs.length,
        child: Scaffold(
          bottomNavigationBar: StylishBottomBar(
              currentIndex: ref.watch(tabbarProvider),
              onTap: (value) {
                pageController.animateToPage(value,
                    duration: Durations.medium1, curve: Curves.easeIn);
                ref.read(tabbarProvider.notifier).state = value;
              },
              items: tabConfigs
                  .map((config) => BottomBarItem(
                      icon: Icon(config.iconData), title: Text(config.tabName)))
                  .toList(),
              option: AnimatedBarOptions(
                  iconStyle: IconStyle.animated,
                  barAnimation: BarAnimation.blink)),
          body: PageView.builder(
            itemCount: tabConfigs.length,
            controller: pageController,
            itemBuilder: (context, index) => tabConfigs[index].page,
          ),
        ));
  }
}
