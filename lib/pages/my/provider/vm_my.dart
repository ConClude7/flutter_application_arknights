import 'package:flutter_application_arknights/models/model_userinfo.dart';
import 'package:flutter_application_arknights/pages/my/services/service_my.dart';
import 'package:flutter_application_arknights/utils/storage_util.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'vm_my.g.dart';

@riverpod
class MyInfoVM extends _$MyInfoVM {
  @override
  Future<Userinfo> build() async {
    final userinfo = await ServiceMy.getMyInfo();
    StorageUtil.setJson(StorageKey.userinfo, userinfo.toMap());
    return userinfo;
  }

  void editInfo() {}
}
