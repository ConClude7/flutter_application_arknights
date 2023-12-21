import 'package:flutter/material.dart';
import 'package:flutter_application_arknights/common/app_bar.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

/// 用户名密码登录页
class LoginPasswordPage extends HookConsumerWidget {
  const LoginPasswordPage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final TextEditingController userNameController = TextEditingController();
    final TextEditingController passWordController = TextEditingController();
    return Scaffold(
      appBar: const HHAppBar(
        showLeading: false,
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: TextField(
              controller: userNameController,
            ),
          ),
          SliverToBoxAdapter(
            child: TextField(
              controller: passWordController,
            ),
          ),
          SliverToBoxAdapter(
            child: FloatingActionButton.large(
              onPressed: () {},
              child: const Text('登录'),
            ),
          )
        ],
      ),
    );
  }
}
