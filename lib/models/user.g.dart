// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User()
  ..username = json['username'] as String
  ..type = json['type'] as String
  ..email = json['email'] as String?
  ..signature = json['signature'] as String?
  ..created = json['created'] as String
  ..updated = json['updated'] as String
  ..lastLogin = json['lastLogin'] as String;

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'username': instance.username,
      'type': instance.type,
      'email': instance.email,
      'signature': instance.signature,
      'created': instance.created,
      'updated': instance.updated,
      'lastLogin': instance.lastLogin,
    };
