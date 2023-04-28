import 'package:json_annotation/json_annotation.dart';

part 'articleComment.g.dart';

@JsonSerializable()
class ArticleComment {
  ArticleComment();

  late String articleId;
  late String userId;
  late String userName;
  late String content;
  late String createAt;
  
  factory ArticleComment.fromJson(Map<String,dynamic> json) => _$ArticleCommentFromJson(json);
  Map<String, dynamic> toJson() => _$ArticleCommentToJson(this);
}
