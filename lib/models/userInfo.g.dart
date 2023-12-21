// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'userInfo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserInfo _$UserInfoFromJson(Map<String, dynamic> json) => UserInfo()
  ..id = json['id'] as String
  ..username = json['username'] as String
  ..avatar = json['avatar'] as String
  ..type = json['type'] as String
  ..email = json['email'] as String?
  ..signature = json['signature'] as String?
  ..created = json['created'] as String
  ..updated = json['updated'] as String
  ..lastLogin = json['lastLogin'] as String;

Map<String, dynamic> _$UserInfoToJson(UserInfo instance) => <String, dynamic>{
      'id': instance.id,
      'username': instance.username,
      'avatar': instance.avatar,
      'type': instance.type,
      'email': instance.email,
      'signature': instance.signature,
      'created': instance.created,
      'updated': instance.updated,
      'lastLogin': instance.lastLogin,
    };
