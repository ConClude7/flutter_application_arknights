import 'package:json_annotation/json_annotation.dart';

part 'userInfo.g.dart';

@JsonSerializable()
class UserInfo {
  UserInfo();

  late String id;
  late String username;
  late String avatar;
  late String type;
  String? email;
  String? signature;
  late String created;
  late String updated;
  late String lastLogin;
  
  factory UserInfo.fromJson(Map<String,dynamic> json) => _$UserInfoFromJson(json);
  Map<String, dynamic> toJson() => _$UserInfoToJson(this);
}
