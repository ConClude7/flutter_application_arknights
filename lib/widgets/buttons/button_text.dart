import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class HHButtonText extends StatefulHookConsumerWidget {
  final String text;
  final VoidCallback onPressed;
  const HHButtonText({super.key, required this.text, required this.onPressed});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HHButtonTextState();
}

class _HHButtonTextState extends ConsumerState<HHButtonText> {
  @override
  Widget build(BuildContext context) {
    return TextButton(onPressed: widget.onPressed, child: Text(widget.text));
  }
}
