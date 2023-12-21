import 'package:flutter/material.dart';
import 'package:flutter_application_arknights/providers/provider_tabbar.dart';
import 'package:flutter_application_arknights/utils/logger.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class MyHomePage extends ConsumerStatefulWidget {
  const MyHomePage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MyHomePageState();
}

class _MyHomePageState extends ConsumerState<MyHomePage> {
  @override
  void initState() {
    logPrint('HomePage.initState');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FloatingActionButton(onPressed: () {
          ref.read(tabbarProvider.notifier).changePage(1);
        }),
      ),
    );
  }
}
