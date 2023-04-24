// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'article.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Article _$ArticleFromJson(Map<String, dynamic> json) => Article()
  ..author = json['author'] as String
  ..title = json['title'] as String
  ..content = json['content'] as String
  ..images = json['images'] as List<dynamic>
  ..keyWord = json['keyWord'] as List<dynamic>
  ..clicks = json['clicks'] as num
  ..talks = json['talks'] as num
  ..deleted = json['deleted'] as bool
  ..createTIme = json['createTIme'] as String
  ..updateTime = json['updateTime'] as String
  ..lastTalkTime = json['lastTalkTime'] as String
  ..articleState = json['articleState'] as String;

Map<String, dynamic> _$ArticleToJson(Article instance) => <String, dynamic>{
      'author': instance.author,
      'title': instance.title,
      'content': instance.content,
      'images': instance.images,
      'keyWord': instance.keyWord,
      'clicks': instance.clicks,
      'talks': instance.talks,
      'deleted': instance.deleted,
      'createTIme': instance.createTIme,
      'updateTime': instance.updateTime,
      'lastTalkTime': instance.lastTalkTime,
      'articleState': instance.articleState,
    };
