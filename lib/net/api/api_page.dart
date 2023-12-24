import 'api_result.dart';

class ApiPaging<T> {
  ApiPaging(this.total, this.empty, this.list);

  /// 总页数
  int? total;

  /// 是否为空
  bool? empty;

  /// 分页list
  List<T>? list;

  ApiPaging.fromJson(Map<String, dynamic> json, FromJson<T> fromJson) {
    total = json['total'];
    empty = json['empty'];
    list = (json['data'] as List<dynamic>?)?.map(fromJson).toList();
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {};
    map['total'] = total;
    map['empty'] = empty;
    map['data'] = list;

    return map;
  }
}
