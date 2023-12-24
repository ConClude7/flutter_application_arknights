import 'package:flutter/material.dart';
import 'package:flutter_application_arknights/common/app_bar.dart';
import 'package:flutter_application_arknights/pages/login/service/service_login.dart';
import 'package:flutter_application_arknights/widgets/buttons/button_text.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

/// 用户名密码登录页

class LoginPasswordPage extends StatefulHookConsumerWidget {
  const LoginPasswordPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _LoginPasswordPageState();
}

class _LoginPasswordPageState extends ConsumerState<LoginPasswordPage> {
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController passWordController = TextEditingController();

  @override
  void dispose() {
    userNameController.dispose();
    passWordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
            child: HHButtonText(
                text: '登陆',
                onPressed: () {
                  LoginService.login(
                      userName: userNameController.text,
                      password: passWordController.text);
                }),
          ),
          SliverToBoxAdapter(
            child: HHButtonText(
                text: '注册',
                onPressed: () {
                  LoginService.register(
                      userName: userNameController.text,
                      password: passWordController.text);
                }),
          ),
        ],
      ),
    );
  }
}
