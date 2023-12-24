import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_application_arknights/models/model_userinfo.dart';
import 'package:flutter_application_arknights/router/app_router.dart';
import 'package:flutter_application_arknights/router/router_path.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StorageKey {
  static String get token => 'token';
  static String get userinfo => 'userinfo';
}

void checkToken({required VoidCallback? onSuccess}) {
  final String? token = StorageUtil.get<String?>(StorageKey.token);
  if (token != null && token != '') {
    onSuccess?.call();
  } else {
    HHRouter.push(HHRouterPath.loginPage);
  }
}

class StorageUtil {
  /// 单例模式
  ///   /// 构造函数
  StorageUtil._initial() {
    init();
  }
  factory StorageUtil() => _instance;
  static final StorageUtil _instance = StorageUtil._initial();
  static SharedPreferences? _preferences;

  /// 初始化SharedPreferences
  static void init() async {
    _preferences ??= await SharedPreferences.getInstance();
  }

  /// 设置String类型的
  static void setString(key, value) {
    _preferences?.setString(key, value);
  }

  /// 设置setStringList类型的
  static void setStringList(key, value) {
    _preferences?.setStringList(key, value);
  }

  /// 设置setBool类型的
  static void setBool(key, value) {
    _preferences?.setBool(key, value);
  }

  /// 设置setDouble类型的
  static void setDouble(key, value) {
    _preferences?.setDouble(key, value);
  }

  /// 设置setInt类型的
  static void setInt(key, value) {
    _preferences?.setInt(key, value);
  }

  /// 存储Json类型的
  static void setJson(key, value) {
    value = jsonEncode(value);
    _preferences?.setString(key, value);
  }

  /// 通过泛型来获取数据
  static T? get<T>(key) {
    var result = _preferences?.get(key);
    if (result != null) {
      return result as T;
    }
    return null;
  }

  static Userinfo? getUserinfo() {
    final userInfoString = get<String>(StorageKey.userinfo);
    if (userInfoString == null || userInfoString == '') return null;
    final userInfo = Userinfo.fromJson(userInfoString);
    return userInfo;
  }

  /// 清除全部
  static void clean() {
    _preferences?.clear();
  }

  /// 移除某一个
  static void remove(key) {
    _preferences?.remove(key);
  }
}
