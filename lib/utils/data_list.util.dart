import 'package:flutter_application_arknights/utils/logger.dart';

class HHDataList<T> {
  final dynamic data;

  HHDataList(this.data);

  List<T> getListModel(T Function(dynamic json) fromJson) {
    final List listData = data?['data']['list'];
    final listModel = listData.map((json) {
      final mapData = json as Map<String, dynamic>;
      logPrint(mapData.toString());
      return fromJson(json);
    }).toList();
    return listModel;
  }
}
