import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class HHTextfield extends StatefulHookConsumerWidget {
  final Function(String textValue) onChanged;
  const HHTextfield({super.key, required this.onChanged});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HHTextfieldState();
}

class _HHTextfieldState extends ConsumerState<HHTextfield> {
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextField(
        controller: _controller,
        onChanged: widget.onChanged,
      ),
    );
  }
}
