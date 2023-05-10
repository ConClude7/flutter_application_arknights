import 'package:json_annotation/json_annotation.dart';

part 'articleCommentReply.g.dart';

@JsonSerializable()
class ArticleCommentReply {
  ArticleCommentReply();

  late String articleId;
  late String commentId;
  late String userId;
  late String userName;
  late String content;
  late String createAt;
  
  factory ArticleCommentReply.fromJson(Map<String,dynamic> json) => _$ArticleCommentReplyFromJson(json);
  Map<String, dynamic> toJson() => _$ArticleCommentReplyToJson(this);
}
