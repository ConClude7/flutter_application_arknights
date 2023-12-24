import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class MessagePage extends StatefulHookConsumerWidget {
  const MessagePage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MessagePageState();
}

class _MessagePageState extends ConsumerState<MessagePage> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
