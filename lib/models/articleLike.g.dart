// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'articleLike.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ArticleLike _$ArticleLikeFromJson(Map<String, dynamic> json) => ArticleLike()
  ..userId = json['userId'] as String
  ..articleId = json['articleId'] as String
  ..createAt = json['createAt'] as String;

Map<String, dynamic> _$ArticleLikeToJson(ArticleLike instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'articleId': instance.articleId,
      'createAt': instance.createAt,
    };
