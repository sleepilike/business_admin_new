import 'dart:async';

import 'package:registration_admin/common/req_model.dart';
import 'package:registration_admin/config/api.dart';
import 'package:registration_admin/entity/apply_entity.dart';

class ApplyRepo{
  //获取全部
  Future getAllList(userID) async{
    try{
      var res = await ReqModel.get(API.APPLY_LIST, {"type":0,"userId":userID});
      print("getAllList success:"+res.toString());
      return Future.value(ApplyEntity.fromJsonList(res));
    }catch(error){
      {print("getAllList error:"+error.toString());
      return Future.error(error);}
    }
  }

  //获取待审核
  Future getWaitList(userID) async{
    try{
      var res = await ReqModel.get(API.APPLY_LIST, {"type":1,"userId":userID});
      print("getWaitList success:"+res.toString());
      return Future.value(ApplyEntity.fromJsonList(res));
    }catch(error){
      print("getWaitList error:"+error.toString());
      return Future.error(error);
    }
  }

  //审核申请
  Future checkApplication(int applicationId,int type,int userId) async{
    try{
      var res = await ReqModel.get(API.CHECKAPP, {"applicationId":applicationId,"type":type,"userId":userId});
      print("checkApplication success:"+res.toString());
      return Future.value();
    }catch(error){
      print("checkApplication error:"+error.toString());
      return Future.error(error);
    }
  }


  //获取已通过
  Future getAcceptList(userID) async{
    try{
      var res = await ReqModel.get(API.APPLY_LIST, {"type":2,"userId":userID});
      print("getAcceptList success:"+res.toString());
      return Future.value(ApplyEntity.fromJsonList(res));
    }catch(error){
      print("getAcceptList error:"+error.toString());
      return Future.error(error);
    }
  }

  //获取拒绝
  Future getRefuseList(userID) async{
    try{
      var res = await ReqModel.get(API.APPLY_LIST, {"type":3,"userId":userID});
      print("getRefuseList success:"+res.toString());
      return Future.value(ApplyEntity.fromJsonList(res));
    }catch(error){
      print("getRefuseList error:"+error.toString());
      return Future.error(error);
    }
  }
}