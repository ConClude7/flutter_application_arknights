import 'package:flutter/material.dart';
import 'package:flutter_application_arknights/router/app_router.dart';
import 'package:flutter_application_arknights/utils/screen_utils.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class HHAppBar extends HookConsumerWidget implements PreferredSizeWidget {
  final String title;
  final Color? backgroundColor;
  final bool showLeading;
  final Widget? leading;
  final VoidCallback? leadingOnTap;
  final List<Widget>? actions;
  const HHAppBar(
      {super.key,
      this.title = '',
      this.showLeading = true,
      this.backgroundColor,
      this.leading,
      this.leadingOnTap,
      this.actions});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AppBar(
      title: Text(title),
      backgroundColor: backgroundColor,
      leading: Visibility(
        visible: showLeading,
        child: leading ??
            IconButton(
                onPressed: leadingOnTap ??
                    () {
                      HHRouter.pop(context);
                    },
                icon: const Icon(Icons.arrow_back_ios_new)),
      ),
      actions: actions,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(HHSize.appBarHeight);
}
