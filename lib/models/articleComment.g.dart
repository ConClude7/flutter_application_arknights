// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'articleComment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ArticleComment _$ArticleCommentFromJson(Map<String, dynamic> json) =>
    ArticleComment()
      ..articleId = json['articleId'] as String
      ..userId = json['userId'] as String
      ..userName = json['userName'] as String
      ..content = json['content'] as String
      ..createAt = json['createAt'] as String;

Map<String, dynamic> _$ArticleCommentToJson(ArticleComment instance) =>
    <String, dynamic>{
      'articleId': instance.articleId,
      'userId': instance.userId,
      'userName': instance.userName,
      'content': instance.content,
      'createAt': instance.createAt,
    };
