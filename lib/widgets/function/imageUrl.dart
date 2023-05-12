import 'package:flutter_application_arknights/common/shared.dart';

Future<List<dynamic>> imagesUrl(imagePath) async {
  final baseUrl = await PersistentStorage().getStorage("url");
  final imagesUrl = [];
  for (var path in imagePath) {
    imagesUrl.add("$baseUrl$path");
  }
  return imagesUrl;
}
