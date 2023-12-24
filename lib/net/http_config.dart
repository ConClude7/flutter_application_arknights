/*
 * @Author: your name
 * @Date: 2023-11-20 17:17:07
 * @LastEditors: Please set LastEditors
 * @Description: In User Settings Edit
 */
import 'dart:io';
import 'package:flutter_application_arknights/utils/storage_util.dart';

class HttpConfig {
  String accessToken = StorageUtil.get<String>(StorageKey.token) ?? '';

  static const baseURL = 'http://192.168.1.103:210/api';
  static const timeOut = Duration(seconds: 15);
  static const receiveTimeout = Duration(seconds: 15);

  /// 普通格式的header
  static Map<String, dynamic> headers = {
    "Accept": "application/json, text/plain, */*",
    "Content-Type": "application/x-www-form-urlencoded",
    "Accept-Language": "zh-CN,zh;q=0.9",
    "Accept-Encoding": "gzip, deflate",
    "agent": Platform.isIOS ? 'ios' : 'android',
    'Authorization': StorageUtil.get<String>(StorageKey.token) ?? ''
  };

  ///json格式的header
  static Map<String, dynamic> headersJson = {
    "Accept": "application/json, text/plain, */*",
    "Content-Type": "application/json; charset=UTF-8",
    "Accept-Language": "zh-CN,zh;q=0.9",
    "Accept-Encoding": "gzip, deflate",
    "agent": Platform.isIOS ? 'ios' : 'android',
    'Authorization': StorageUtil.get<String>(StorageKey.token) ?? ''
  };
}
