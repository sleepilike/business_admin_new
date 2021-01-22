
import 'package:flutter/foundation.dart';
import 'package:registration_admin/common/check.dart';
import 'package:registration_admin/data/apply_repo.dart';
import 'package:registration_admin/entity/apply_entity.dart';

class ApplyStateModel extends ChangeNotifier{

  bool _allState = false;
  bool _waitState = false;
  bool _acceptState = false;
  bool _refuseState = false;

  ApplyRepo _applyRepo = new ApplyRepo();
  List<ApplyEntity> _allList ;
  List<ApplyEntity> _waitList;
  List<ApplyEntity> _acceptList;
  List<ApplyEntity> _refuseList;

  List<ApplyEntity> get allList => _allList;
  List<ApplyEntity> get waitList => _waitList;
  List<ApplyEntity> get acceptList => _acceptList;
  List<ApplyEntity> get refuseList => _refuseList;

  get state => _allState&&_waitState&&_acceptState&&_refuseState;
  get hasAll => _allState;
  get hasWait => _waitState;
  get hasAccept => _acceptState;
  get hasRefuse => _refuseState;


  init(userID) async{
    print("ApplyStateModel init exec");
    try{
      _allList = await _applyRepo.getAllList(userID);
      _allState =true;
      _acceptList = await _applyRepo.getAcceptList(userID);
      _acceptState = true;
      _waitList = await _applyRepo.getWaitList(userID);
      _waitState = true;
      _refuseList = await _applyRepo.getRefuseList(userID);
      _refuseState = true;

      notifyListeners();
    }catch(error){
      print("ApplyStateModel init eeror"+error.toString());
    }
  }

  check(int applicationId,int type,int userId) async{
    print("applyStateModel check");
    try{
      await _applyRepo.checkApplication(applicationId, type, userId);
      init(userId);
      notifyListeners();

    }catch(error){
      print("applyStateModel check error:"+error.toString());

    }
  }


}