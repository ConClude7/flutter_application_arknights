import 'package:dismissible_page/dismissible_page.dart';
import 'package:flutter/material.dart';

class PhotoShow extends StatelessWidget {
  final List<dynamic> images;
  final String tagName;
  final int iamgeIndex;
  const PhotoShow(
      {super.key,
      required this.images,
      required this.tagName,
      required this.iamgeIndex});

  @override
  Widget build(BuildContext context) {
    print("Get:$tagName");
    return DismissiblePage(
      backgroundColor: const Color.fromARGB(255, 52, 52, 52),
      onDismissed: () {
        print("Leave:$tagName");
        Navigator.of(context).pop();
      },
      /* direction: DismissiblePageDismissDirection.multi, */
      isFullScreen: false,
      child: Hero(
          tag: tagName,
          child: Image.memory(
            images[iamgeIndex],
            fit: BoxFit.contain,
          )),
    );
  }
}
