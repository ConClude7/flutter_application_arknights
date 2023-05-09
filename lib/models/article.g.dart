// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'article.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Article _$ArticleFromJson(Map<String, dynamic> json) => Article()
  ..id = json['_id'] as String
  ..author = json['author'] as String
  ..authorName = json['authorName'] as String
  ..title = json['title'] as String
  ..content = json['content'] as String
  ..images = json['images'] as List<dynamic>
  ..keyWords = json['keyWords'] as List<dynamic>
  ..clicks = json['clicks'] as num
  ..likes = json['likes'] as num
  ..talks = json['talks'] as num
  ..deleted = json['deleted'] as bool
  ..createTime = json['createTime'] as String
  ..updateTime = json['updateTime'] as String
  ..lastTalkTime = json['lastTalkTime'] as String
  ..articleState = json['articleState'] as String;

Map<String, dynamic> _$ArticleToJson(Article instance) => <String, dynamic>{
      '_id': instance.id,
      'author': instance.author,
      'authorName': instance.authorName,
      'title': instance.title,
      'content': instance.content,
      'images': instance.images,
      'keyWords': instance.keyWords,
      'clicks': instance.clicks,
      'likes': instance.likes,
      'talks': instance.talks,
      'deleted': instance.deleted,
      'createTime': instance.createTime,
      'updateTime': instance.updateTime,
      'lastTalkTime': instance.lastTalkTime,
      'articleState': instance.articleState,
    };
