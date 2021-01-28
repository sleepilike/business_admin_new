

import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:registration_admin/config/config.dart';
import 'package:registration_admin/data/apply_state_model.dart';
import 'package:registration_admin/data/monitor_state_model.dart';
import 'package:registration_admin/data/user_state_model.dart';
import 'package:registration_admin/entity/apply_entity.dart';
import 'package:registration_admin/entity/apply_rol_entity.dart';
import 'package:registration_admin/entity/worker_entity.dart';
import 'package:registration_admin/ui/mainwidget/detail.dart';
import 'package:registration_admin/ui/widget/non_register_widget.dart';

import '../widget/card_item.dart';

class PersonPage extends StatefulWidget {
  @override
  _PersonPageState createState() => _PersonPageState();
}

class _PersonPageState extends State<PersonPage> {
  @override
  Widget build(BuildContext context) {
    return CardItem(
        title: "审核信息",
        child: Consumer<ApplyStateModel>(
          builder:
              (BuildContext context, ApplyStateModel value, Widget child) {
            return CheckInfor(value.allList,value.hasAll,
                value.waitList,value.hasWait,
                value.acceptList,value.hasAccept,
                value.refuseList,value.hasRefuse,value.state);
          },
        )

    );
  }
}

class CheckInfor extends StatefulWidget{
  List<ApplyEntity> allList = new List<ApplyEntity>();
  List<ApplyEntity> waitList= new List<ApplyEntity>();
  List<ApplyEntity> acceptList= new List<ApplyEntity>();
  List<ApplyEntity> refuseList= new List<ApplyEntity>();

  bool hasAll;
  bool hasWait;
  bool hasAccept;
  bool hasRefuse;
  bool state;
  CheckInfor(this.allList,this.hasAll,this.waitList,this.hasWait,
      this.acceptList,this.hasAccept,this.refuseList,this.hasRefuse,this.state);
  @override
  State<StatefulWidget> createState() {
    return _CheckInforState();
  }
}
class _CheckInforState extends State<CheckInfor>{



  List<int> mList;
  List<ExpandStateBean> expandStateList;
  _CheckInforState(){
    mList = new List();
    expandStateList = new List();
    for(int i=0;i<4;i++){
      mList.add(i);
      expandStateList.add(ExpandStateBean(i, false));
    }

  }
  _setCurrentIndex(int index,isExpand){
    setState(() {
      //遍历可展开状态列表
      expandStateList.forEach((item){
        if(item.index==index){
          item.isOpen=!isExpand;
        }
      });
    });
  }
  @override
  Widget build(BuildContext context) {

    return ExpansionPanelList(
      expansionCallback: (index,bol){
        _setCurrentIndex(index, bol);
      },
      children: mList.map((index){
        //返回一个组成的ExpansionPanel
        return ExpansionPanel(
            headerBuilder: (context,isExpanded){
              return GestureDetector(
                //标题
                child: title(index, index==0?(widget.hasAll?widget.allList.length:0):
                index==1?(widget.hasWait?widget.waitList.length:0):
                index==2?(widget.hasAccept?widget.acceptList.length:0):
                (widget.hasRefuse?widget.refuseList.length:0)),
                onTap: (){
                  //调用内部方法
                  _setCurrentIndex(index, expandStateList[index].isOpen);
                },
              );
            },
            body: Container(
              child:widget.state? Two(index,index==0?widget.allList:index==1?widget.waitList:
              index==2?widget.acceptList:widget.refuseList):Container()
            ),
            isExpanded: expandStateList[index].isOpen
        );
      }).toList(),
    );

  }

}
//list中item状态自定义类
class ExpandStateBean{
  var isOpen;   //item是否打开
  var index;    //item中的索引
  ExpandStateBean(this.index,this.isOpen);
}

Widget title(int index,int num){
  return Padding(
    padding: EdgeInsets.all(5.0),
    child: Stack(
      children: [
        Container(
          child: ListTile(
            title: Text(index == 0?"全部":index == 1? "待我审核":index == 2?"我已同意":"我不同意",
              style: new TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700
              ),),
          ),
        ),
        index == 0?Container():Positioned(
            left: 80.0,
            top: 10.0,
            child: num>0?Container(
              padding: EdgeInsets.only(left: 1.0,right: 1.0,top: 2.0,bottom: 2.0),
              width: 16,
              height: 16,
              child: Center(
                  child: Text(num.toString(),
                    style: TextStyle(
                        fontSize: 10.0, color: Colors.red ),)
              ),
              decoration: BoxDecoration(
                border: new Border.all(color: Colors.red, width: 1.0), // 边色与边宽度
                color: Colors.white, // 底色
                //        borderRadius: new BorderRadius.circular((20.0)), // 圆角度
                borderRadius: new BorderRadius.circular((20.0)),
              ),
            ):Text("")
        )
      ],
    ),
  );
}


Widget applyListWidget(BuildContext context,int index,List applyList){
  if(applyList.length==0)
    return NonDataWidget();
  else{
    List<Widget> _list = new List();
    for(int i=0;i<applyList.length;i++){
      _list.add(Container(
        padding: EdgeInsets.only(left: 20.0,right: 10.0),
        child:applyOneWidge(context,index, applyList[i]) ,
      ));
    }
    return ListView(
      shrinkWrap: true ,
      children:_list,
    );
  }
}
Widget applyOneWidge(BuildContext context,int index,ApplyEntity applyEntity){
  UserStateModel userStateModel = Provider.of<UserStateModel>(context, listen: false);
  ApplyRolEntity applyRolEntity = new ApplyRolEntity(applyEntity, userStateModel.user);
  String start = applyEntity.startTime.substring(0,10);
  List startsp = start.split("-");
  String end = applyEntity.endTime.substring(0,10);
  List endsp = end.split("-");
  return InkWell(
    onTap: (){
      showDetaliDialog(context, applyEntity);
    },
    highlightColor: Colors.green,
    child: Column(
      children: [
        Container(
          padding: EdgeInsets.all(5.0),
          height: 80.0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  index==0?Row(
                    children: [
                      Text('${applyEntity.applicant}   ',
                          style: TextStyle(fontSize:16.0,color: applyRolEntity.state==0?Colors.orange:
                          applyRolEntity.state == 1?Colors.green:Colors.redAccent)),
                      Text(applyRolEntity.state==0?"(待我审核)":
                      applyRolEntity.state ==1?"(我已同意)":"(我不同意)",
                          style: TextStyle(color: applyRolEntity.state==0?Colors.orange:
                          applyRolEntity.state ==1?Colors.green:Colors.redAccent))
                    ],
                  ):Text('${applyEntity.applicant}',style: TextStyle(fontSize: 16.0),),
                  Container(height: 5.0,),
                  Expanded(
                    child: Text('${applyEntity.departure} — ${applyEntity.destination}',style: TextStyle(color: Colors.grey,fontSize: 15.0),),
                  ),
                  Text('${startsp[0]}年${startsp[1]}月${startsp[2]}日 — ${endsp[0]}年${endsp[1]}月${endsp[2]}日',style: TextStyle(color: Colors.grey,fontSize: 15.0))
                ],
              ),
              Icon(Icons.keyboard_arrow_right,color: Colors.grey[500],)
            ],
          ),
        ),

        Container(height: 1.0,color:Colors.grey[100],)
      ],
    ),
  );
}
showDetaliDialog(BuildContext context,ApplyEntity applyEntity) async{
  UserStateModel userStateModel = Provider.of<UserStateModel>(context, listen: false);
  ApplyStateModel applyStateModel = Provider.of<ApplyStateModel>(context, listen: false);
  int rol = userStateModel.user.firstPositionId;
  int userId = userStateModel.user.id;
  Navigator.push(context,
      MaterialPageRoute(builder: (context) => DetailPage(rol,userId,applyStateModel,applyEntity)));
}

//二级展开列表
class Two extends StatefulWidget {
  int order;
  List<ApplyEntity> applyList;
  //近三天
  List<ApplyEntity> before = new List<ApplyEntity>();
  //其他
  List<ApplyEntity> after = new List<ApplyEntity>();
  Two(int order,List<ApplyEntity> applyList){
    this.order = order;
    this.applyList = applyList;
    for(int i = 0;i<this.applyList.length;i++){
      String applyTime = this.applyList[i].applyTime.substring(0,10);
      List time = applyTime.split("-");
      if(isOver(time[0], time[1], time[2])){
        after.add(this.applyList[i]);
      }
      else
        before.add(this.applyList[i]);
    }
  }
  @override
  _TwoState createState() => _TwoState();
}

class _TwoState extends State<Two> {

  List<int> mList;
  List<ExpandStateBean> expandStateList;
  _TwoState(){
    mList = new List();
    expandStateList = new List();
    for(int i=0;i<2;i++){
      mList.add(i);
      expandStateList.add(ExpandStateBean(i, false));
    }
  }
  _setCurrentIndex(int index,isExpand){
    setState(() {
      //遍历可展开状态列表
      expandStateList.forEach((item){
        if(item.index==index){
          item.isOpen=!isExpand;
        }
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return ExpansionPanelList(
      expansionCallback: (index,bol){
        _setCurrentIndex(index, bol);
      },
      children: mList.map((index){
        //返回一个组成的ExpansionPanel
        return ExpansionPanel(
            headerBuilder: (context,isExpanded){
              return GestureDetector(
                child: Container(
                  padding: EdgeInsets.only(left: 20.0),
                  child: ListTile(
                    title: Text(index == 0?"近三天":"更早",style: TextStyle(
                    fontSize: 16,
                    fontWeight:FontWeight.w600
                  ),),
                ),),
                onTap: (){
                  //调用内部方法
                  _setCurrentIndex(index, expandStateList[index].isOpen);
                },
              );
            },
            body: Container(
                child:applyListWidget(context,widget.order, index==0?widget.before:widget.after)
            ),
            isExpanded: expandStateList[index].isOpen
        );
      }).toList(),
    );
  }
}
