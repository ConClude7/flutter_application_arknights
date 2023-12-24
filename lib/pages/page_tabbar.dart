import 'package:flutter/material.dart';
import 'package:flutter_application_arknights/common/static/animation_duration.dart';
import 'package:flutter_application_arknights/providers/provider_tabbar.dart';
import 'package:flutter_application_arknights/utils/screen_utils.dart';
import 'package:flutter_application_arknights/utils/storage_util.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class TabbarPage extends StatefulHookConsumerWidget {
  const TabbarPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _TabbarPageState();
}

class _TabbarPageState extends ConsumerState<TabbarPage> {
  final PageController _pageController = PageController();

  @override
  void initState() {
    Future(() {
      ref.read(tabbarProvider.notifier).state = 0;
    });
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void changePage(int pageIndex) {
    _pageController.animateToPage(pageIndex,
        duration: HHDuration.shortAnimated, curve: Curves.easeIn);
  }

  @override
  Widget build(BuildContext context) {
    final tabbarIndexWatch = ref.watch(tabbarProvider);
    ref.listen(tabbarProvider, (old, next) {
      changePage(next);
    });

    return DefaultTabController(
        length: pageConfigs.length,
        child: Scaffold(
          bottomNavigationBar: Theme(
              data: Theme.of(context).copyWith(
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent),
              child: BottomNavigationBar(
                  currentIndex: tabbarIndexWatch < 0 ? 0 : tabbarIndexWatch,
                  type: BottomNavigationBarType.fixed,
                  showUnselectedLabels: true,
                  onTap: (value) {
                    if (value > 1) {
                      checkToken(onSuccess: () {
                        changePage(value);
                        ref.read(tabbarProvider.notifier).state = value;
                      });
                    } else {
                      changePage(value);
                      ref.read(tabbarProvider.notifier).state = value;
                    }
                  },
                  items: pageConfigs.asMap().keys.map((int index) {
                    final TabConfig config = pageConfigs[index];
                    final bool isSelected = index == tabbarIndexWatch;
                    final BottomNavigationBarItem widget =
                        BottomNavigationBarItem(
                            label: config.tabName,
                            tooltip: '',
                            icon: Card(
                                shape: ContinuousRectangleBorder(
                                    borderRadius: BorderRadius.circular(5.r)),
                                child: _BottomBarAnimatedItem(
                                  tabConfig: config,
                                  index: index,
                                  child: Icon(
                                    isSelected
                                        ? config.selectedIcon
                                        : config.iconData,
                                  ),
                                )));
                    return widget;
                  }).toList())),
          body: PageView.builder(
            itemCount: pageConfigs.length,
            controller: _pageController,
            itemBuilder: (context, index) => pageConfigs[index].page,
          ),
        ));
  }
}

class _BottomBarAnimatedItem extends HookConsumerWidget {
  final TabConfig tabConfig;
  final Widget child;
  final int index;
  const _BottomBarAnimatedItem(
      {required this.tabConfig, required this.child, required this.index});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final animatedController =
        useAnimationController(duration: HHDuration.shortAnimated);
    final animation = useAnimation(
        Tween<double>(begin: 50.toW, end: 80.toW).animate(animatedController));

    ref.listen(tabbarProvider, (old, next) {
      if (next == index) {
        animatedController.forward();
      } else {
        animatedController.reverse();
      }
    });
    return SizedBox(
      width: animation,
      child: child,
    );
  }
}
