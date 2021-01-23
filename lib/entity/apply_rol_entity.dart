import 'package:registration_admin/entity/apply_entity.dart';
import 'package:registration_admin/entity/user_entity.dart';

class ApplyRolEntity{
  ApplyEntity applyEntity;
  UserEntity userEntity;
  int _state;//0 待审核 1 已通过 2 未通过
  get state => _state;

  ApplyRolEntity(this.applyEntity,this.userEntity){
    int rol = userEntity.firstPositionId;
    if((applyEntity.status == 0&&rol==2)||(applyEntity.status==2&&rol==1))
      this._state = 0;
    else if((applyEntity.status == 2&&rol==2)||(applyEntity.status==4&&rol==1))
      this._state = 1;
    else
      this._state = 2;
  }


}