

import 'package:flutter/foundation.dart';
import 'package:registration_admin/entity/institue_entity.dart';
import 'package:registration_admin/entity/user_entity.dart';

import 'user_repo.dart';

class UserStateModel extends ChangeNotifier {
  UserRepo _repository = UserRepo();
  UserEntity _user;
  bool _autoLogin = false;


  UserEntity get user => _user;

  bool get autoLogin => _autoLogin;

  bool get isLogin => _user != null;

  Future init () async {
    try {
      _user = await _repository.init();
      //如果已经登录过，会继续执行，否则直接catch error
      _autoLogin = true;
      notifyListeners();
      return Future.value();
    } catch(error) {
      // 无记录账号密码
    }
  }

  Future login(String identityID) async {
    try {
      _user = await _repository.login(identityID);
      notifyListeners();
      return Future.value();
    } catch (error) {
      return Future.error(error);
    }
  }

  void logout() {
    _repository.logout();
    _user = null;
    _autoLogin = false;
  }
}