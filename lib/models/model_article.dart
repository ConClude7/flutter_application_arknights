import 'dart:convert';

class Article {
  String? authorId;
  String? title;
  String? intro;
  String? content;
  List<dynamic>? images;
  String? videoUrl;
  int? clickCount;
  int? likeCount;
  int? collectCount;
  int? commentCount;
  int? shareCount;
  int? createTime;
  int? updateTime;
  int? lastCommentTime;
  int? status;
  bool? deleted;
  String? articleId;

  Article({
    this.authorId,
    this.title,
    this.intro,
    this.content,
    this.images,
    this.videoUrl,
    this.clickCount,
    this.likeCount,
    this.collectCount,
    this.commentCount,
    this.shareCount,
    this.createTime,
    this.updateTime,
    this.lastCommentTime,
    this.status,
    this.deleted,
    this.articleId,
  });

  @override
  String toString() {
    return 'Article(authorId: $authorId, title: $title, intro: $intro, content: $content, images: $images, videoUrl: $videoUrl, clickCount: $clickCount, likeCount: $likeCount, collectCount: $collectCount, commentCount: $commentCount, shareCount: $shareCount, createTime: $createTime, updateTime: $updateTime, lastCommentTime: $lastCommentTime, status: $status, deleted: $deleted, articleId: $articleId)';
  }

  factory Article.fromMap(Map<String, dynamic> data) => Article(
        authorId: data['authorId'] as String?,
        title: data['title'] as String?,
        intro: data['intro'] as String?,
        content: data['content'] as String?,
        images: data['images'] as List<dynamic>?,
        videoUrl: data['videoUrl'] as String?,
        clickCount: data['clickCount'] as int?,
        likeCount: data['likeCount'] as int?,
        collectCount: data['collectCount'] as int?,
        commentCount: data['commentCount'] as int?,
        shareCount: data['shareCount'] as int?,
        createTime: data['createTime'] as int?,
        updateTime: data['updateTime'] as int?,
        lastCommentTime: data['lastCommentTime'] as int?,
        status: data['status'] as int?,
        deleted: data['deleted'] as bool?,
        articleId: data['articleId'] as String?,
      );

  Map<String, dynamic> toMap() => {
        'authorId': authorId,
        'title': title,
        'intro': intro,
        'content': content,
        'images': images,
        'videoUrl': videoUrl,
        'clickCount': clickCount,
        'likeCount': likeCount,
        'collectCount': collectCount,
        'commentCount': commentCount,
        'shareCount': shareCount,
        'createTime': createTime,
        'updateTime': updateTime,
        'lastCommentTime': lastCommentTime,
        'status': status,
        'deleted': deleted,
        'articleId': articleId,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Article].
  factory Article.fromJson(String data) {
    return Article.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [Article] to a JSON string.
  String toJson() => json.encode(toMap());

  Article copyWith({
    String? authorId,
    String? title,
    String? intro,
    String? content,
    List<dynamic>? images,
    String? videoUrl,
    int? clickCount,
    int? likeCount,
    int? collectCount,
    int? commentCount,
    int? shareCount,
    int? createTime,
    int? updateTime,
    int? lastCommentTime,
    int? status,
    bool? deleted,
    String? articleId,
  }) {
    return Article(
      authorId: authorId ?? this.authorId,
      title: title ?? this.title,
      intro: intro ?? this.intro,
      content: content ?? this.content,
      images: images ?? this.images,
      videoUrl: videoUrl ?? this.videoUrl,
      clickCount: clickCount ?? this.clickCount,
      likeCount: likeCount ?? this.likeCount,
      collectCount: collectCount ?? this.collectCount,
      commentCount: commentCount ?? this.commentCount,
      shareCount: shareCount ?? this.shareCount,
      createTime: createTime ?? this.createTime,
      updateTime: updateTime ?? this.updateTime,
      lastCommentTime: lastCommentTime ?? this.lastCommentTime,
      status: status ?? this.status,
      deleted: deleted ?? this.deleted,
      articleId: articleId ?? this.articleId,
    );
  }
}
