// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User()
  ..userId = json['userId'] as String
  ..username = json['username'] as String
  ..type = json['type'] as String
  ..email = json['email'] as String?
  ..says = json['says'] as String
  ..created = json['created'] as String
  ..updated = json['updated'] as String
  ..lastLogin = json['lastLogin'] as String;

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'userId': instance.userId,
      'username': instance.username,
      'type': instance.type,
      'email': instance.email,
      'says': instance.says,
      'created': instance.created,
      'updated': instance.updated,
      'lastLogin': instance.lastLogin,
    };
