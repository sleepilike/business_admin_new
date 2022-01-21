

import 'package:registration_admin/common/req_model.dart';
import 'package:registration_admin/entity/user_entity.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../config/api.dart';


const KEY_IDENTUTYID = "identityID";
class UserRepo {
  Future init() async {
    try {
      SharedPreferences sp = await SharedPreferences.getInstance();
      String identityID = sp.getString(KEY_IDENTUTYID);
      print('初始化， 获取账号：' + identityID);
      if (identityID==null )
        return Future.error('无初始登陆状态');
      return login(identityID);
    } catch (error) {
      return Future.error(error);
    }
  }

  Future login(String identityID) async {
    try {
      var res = await ReqModel.get(API.LOGIN, {"identityId": identityID});
      SharedPreferences sp = await SharedPreferences.getInstance();
      sp.setString(KEY_IDENTUTYID,identityID);


      return Future.value(UserEntity.fromJson(res));
    } catch (error) {
      return Future.error(error);
    }
  }

  /// 登出，清除sp
  void logout() {

  }

}