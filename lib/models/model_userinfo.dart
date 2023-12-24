import 'dart:convert';

class Userinfo {
  String? nickname;
  String? password;
  String? avatar;
  int? gender;
  String? backgoundImg;
  String? signature;
  int? createTime;
  int? updateTime;
  int? lastLogin;
  int? statusCode;
  String? memberId;

  Userinfo({
    this.nickname,
    this.password,
    this.avatar,
    this.gender,
    this.backgoundImg,
    this.signature,
    this.createTime,
    this.updateTime,
    this.lastLogin,
    this.statusCode,
    this.memberId,
  });

  @override
  String toString() {
    return 'Userinfo( nickname: $nickname, password: $password, avatar: $avatar, gender: $gender, backgoundImg: $backgoundImg, signature: $signature, createTime: $createTime, updateTime: $updateTime, lastLogin: $lastLogin, statusCode: $statusCode, memberId: $memberId)';
  }

  factory Userinfo.fromMap(Map<String, dynamic> data) => Userinfo(
        nickname: data['nickname'] as String?,
        password: data['password'] as String?,
        avatar: data['avatar'] as String?,
        gender: data['gender'] as int?,
        backgoundImg: data['backgoundImg'] as String?,
        signature: data['signature'] as String?,
        createTime: data['createTime'] as int?,
        updateTime: data['updateTime'] as int?,
        lastLogin: data['lastLogin'] as int?,
        statusCode: data['statusCode'] as int?,
        memberId: data['memberId'] as String?,
      );

  Map<String, dynamic> toMap() => {
        'nickname': nickname,
        'password': password,
        'avatar': avatar,
        'gender': gender,
        'backgoundImg': backgoundImg,
        'signature': signature,
        'createTime': createTime,
        'updateTime': updateTime,
        'lastLogin': lastLogin,
        'statusCode': statusCode,
        'memberId': memberId,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Userinfo].
  factory Userinfo.fromJson(String data) {
    return Userinfo.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [Userinfo] to a JSON string.
  String toJson() => json.encode(toMap());

  Userinfo copyWith({
    String? nickname,
    String? password,
    String? avatar,
    int? gender,
    String? backgoundImg,
    String? signature,
    int? createTime,
    int? updateTime,
    int? lastLogin,
    int? statusCode,
    String? memberId,
  }) {
    return Userinfo(
      nickname: nickname ?? this.nickname,
      password: password ?? this.password,
      avatar: avatar ?? this.avatar,
      gender: gender ?? this.gender,
      backgoundImg: backgoundImg ?? this.backgoundImg,
      signature: signature ?? this.signature,
      createTime: createTime ?? this.createTime,
      updateTime: updateTime ?? this.updateTime,
      lastLogin: lastLogin ?? this.lastLogin,
      statusCode: statusCode ?? this.statusCode,
      memberId: memberId ?? this.memberId,
    );
  }
}
