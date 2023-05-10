// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Profile _$ProfileFromJson(Map<String, dynamic> json) => Profile()
  ..userId = User.fromJson(json['userId'] as Map<String, dynamic>)
  ..token = json['token'] as String
  ..theme = json['theme'] as num
  ..cache = CacheConfig.fromJson(json['cache'] as Map<String, dynamic>)
  ..lastLogin = json['lastLogin'] as String
  ..location = json['location'] as String;

Map<String, dynamic> _$ProfileToJson(Profile instance) => <String, dynamic>{
      'userId': instance.userId,
      'token': instance.token,
      'theme': instance.theme,
      'cache': instance.cache,
      'lastLogin': instance.lastLogin,
      'location': instance.location,
    };
