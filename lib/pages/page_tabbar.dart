import 'package:flutter/material.dart';
import 'package:flutter_application_arknights/common/static/animation_duration.dart';
import 'package:flutter_application_arknights/providers/provider_tabbar.dart';
import 'package:flutter_application_arknights/utils/screen_utils.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class TabbarPage extends StatefulHookConsumerWidget {
  const TabbarPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _TabbarPageState();
}

class _TabbarPageState extends ConsumerState<TabbarPage> {
  @override
  void initState() {
    Future(() {
      ref.read(tabbarProvider.notifier).changePage(0);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final List<TabConfig> tabConfigs =
        ref.watch(tabbarProvider.select((value) => value.pageConfigs));

    return DefaultTabController(
        length: tabConfigs.length,
        child: Scaffold(
          bottomNavigationBar: Theme(
              data: Theme.of(context).copyWith(
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent),
              child: BottomNavigationBar(
                  currentIndex: ref
                      .watch(tabbarProvider.select((value) => value.pageIndex)),
                  type: BottomNavigationBarType.fixed,
                  showUnselectedLabels: true,
                  onTap: (value) {
                    ref.read(tabbarProvider.notifier).changePage(value);
                  },
                  items: tabConfigs.asMap().keys.map((int index) {
                    final TabConfig config = tabConfigs[index];
                    final bool isSelected = ref.watch(tabbarProvider
                            .select((value) => value.pageIndex)) ==
                        index;
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
            itemCount: tabConfigs.length,
            controller: ref
                .watch(tabbarProvider.select((value) => value.pageController)),
            itemBuilder: (context, index) => tabConfigs[index].page,
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

    ref.listen(tabbarProvider.select((value) => value.pageIndex), (old, next) {
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
