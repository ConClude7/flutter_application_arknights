import 'package:json_annotation/json_annotation.dart';

part 'articleLike.g.dart';

@JsonSerializable()
class ArticleLike {
  ArticleLike();

  late String userId;
  late String articleId;
  late String createAt;
  
  factory ArticleLike.fromJson(Map<String,dynamic> json) => _$ArticleLikeFromJson(json);
  Map<String, dynamic> toJson() => _$ArticleLikeToJson(this);
}
