import 'package:flutter_application_arknights/models/userInfo.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class MyUserInfoProvider {
  MyUserInfoProvider({required UserInfo userInfo}) {
    _userInfo = userInfo;
  }

  late UserInfo _userInfo;
  UserInfo? get userInfo => _userInfo;

  MyUserInfoProvider changeInfo({required UserInfo newInfo}) {
    _userInfo = newInfo;
    return MyUserInfoProvider(userInfo: _userInfo);
  }

  @override
  String toString() {
    return _userInfo.toString();
  }
}

class MyUserInfoManager extends StateNotifier<MyUserInfoProvider> {
  MyUserInfoManager(super._state);

  void changeInfo({required UserInfo newInfo}) {
    state = state.changeInfo(newInfo: newInfo);
  }
}

final myUserInfoProvider =
    StateNotifierProvider<MyUserInfoManager, MyUserInfoProvider>((ref) {
  return MyUserInfoManager(MyUserInfoProvider(userInfo: UserInfo()));
});
