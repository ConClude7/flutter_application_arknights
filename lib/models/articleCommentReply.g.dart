// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'articleCommentReply.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ArticleCommentReply _$ArticleCommentReplyFromJson(Map<String, dynamic> json) =>
    ArticleCommentReply()
      ..articleId = json['articleId'] as String
      ..commentId = json['commentId'] as String
      ..userId = json['userId'] as String
      ..userName = json['userName'] as String
      ..content = json['content'] as String
      ..createAt = json['createAt'] as String;

Map<String, dynamic> _$ArticleCommentReplyToJson(
        ArticleCommentReply instance) =>
    <String, dynamic>{
      'articleId': instance.articleId,
      'commentId': instance.commentId,
      'userId': instance.userId,
      'userName': instance.userName,
      'content': instance.content,
      'createAt': instance.createAt,
    };
