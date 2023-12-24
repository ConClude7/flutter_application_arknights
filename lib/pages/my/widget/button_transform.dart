import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ButtonMyTransfrom extends StatefulHookConsumerWidget {
  final VoidCallback onPressed;
  final String text;
  const ButtonMyTransfrom(
      {super.key, required this.onPressed, required this.text});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ButtonMyTransfromState();
}

class _ButtonMyTransfromState extends ConsumerState<ButtonMyTransfrom> {
  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: widget.onPressed,
      child: Text(widget.text),
    );
  }
}
