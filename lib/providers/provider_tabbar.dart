import 'package:flutter/material.dart';
import 'package:flutter_application_arknights/pages/find/page_find.dart';
import 'package:flutter_application_arknights/pages/home/page_home.dart';
import 'package:flutter_application_arknights/pages/message/page_message.dart';
import 'package:flutter_application_arknights/pages/my/page_my.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final tabbarProvider = StateProvider<int>((ref) {
  return -1;
});

final List<TabConfig> pageConfigs = [
  TabConfig(const MyHomePage(), Icons.home_outlined, Icons.home_filled, '首页'),
  TabConfig(const FindPage(), Icons.flutter_dash_outlined,
      Icons.flutter_dash_rounded, '发现'),
  TabConfig(const MessagePage(), Icons.pets, Icons.pets_rounded, '消息'),
  TabConfig(const MyPage(), Icons.person_outline, Icons.person, '我的'),
];

/// PageView配置
class TabConfig {
  final Widget page;
  final IconData iconData;
  final IconData selectedIcon;
  final String tabName;

  TabConfig(this.page, this.iconData, this.selectedIcon, this.tabName);
}

/* class TabbarProvider {
  TabbarProvider({required int pageIndex}) {
    _pageIndex = pageIndex;
  }

  late int _pageIndex;
  int get pageIndex => _pageIndex;

  final List<TabConfig> _pageConfigs = [
    TabConfig(const MyHomePage(), Icons.home_outlined, Icons.home_filled, '首页'),
    TabConfig(const MyHomePage(), Icons.flutter_dash_outlined,
        Icons.flutter_dash_rounded, '发现'),
    TabConfig(const MyPage(), Icons.pets, Icons.pets_rounded, '消息'),
    TabConfig(const MyPage(), Icons.person_outline, Icons.person, '我的'),
  ];

  List<TabConfig> get pageConfigs => _pageConfigs;

  late PageController _pageController;
  PageController get pageController => _pageController;

  TabbarProvider changePage(int newIndex, bool useAnimated) {
    _pageIndex = newIndex;
    if (useAnimated) {
      pageController.animateToPage(_pageIndex,
          duration: HHDuration.middleAnimated, curve: Curves.easeIn);
    }
    return TabbarProvider(pageIndex: _pageIndex);
  }

  TabbarProvider setPageController(PageController pageController) {
    _pageController = pageController;
    return TabbarProvider(pageIndex: pageIndex);
  }
}

class TabBarManager extends StateNotifier<TabbarProvider> {
  TabBarManager(super.state);

  void changePage(int newIndex, {bool? useAnimated}) {
    state = state.changePage(newIndex, useAnimated ?? true);
  }

  void setPageController(PageController pageController) {
    state = state.setPageController(pageController);
  }
}

final tabbarProvider =
    StateNotifierProvider<TabBarManager, TabbarProvider>((ref) {
  return TabBarManager(TabbarProvider(pageIndex: 1));
});
 */
