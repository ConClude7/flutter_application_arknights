import 'package:json_annotation/json_annotation.dart';

part 'article.g.dart';

@JsonSerializable()
class Article {
  Article();

  late String author;
  late String authorName;
  late String title;
  late String content;
  late List images;
  late List keyWords;
  late num clicks;
  late num likes;
  late num talks;
  late bool deleted;
  late String createTime;
  late String updateTime;
  late String lastTalkTime;
  late String articleState;
  
  factory Article.fromJson(Map<String,dynamic> json) => _$ArticleFromJson(json);
  Map<String, dynamic> toJson() => _$ArticleToJson(this);
}
