

import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:registration_admin/data/apply_state_model.dart';
import 'package:registration_admin/data/monitor_state_model.dart';
import 'package:registration_admin/data/user_state_model.dart';
import 'package:registration_admin/entity/apply_entity.dart';
import 'package:registration_admin/entity/worker_entity.dart';
import 'package:registration_admin/ui/mainwidget/detail.dart';
import 'package:registration_admin/ui/widget/non_register_widget.dart';

import '../widget/card_item.dart';

class PersonPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CardItem(
        title: "审核信息",
        child: Consumer<ApplyStateModel>(
          builder:
              (BuildContext context, ApplyStateModel value, Widget child) {
            return CheckInfoWidget(value.allList,value.hasAll,
                value.waitList,value.hasWait,
                value.acceptList,value.hasAccept,
                value.refuseList,value.hasRefuse,value.state);
          },
        )

   );
  }
}

class CheckInfoWidget extends StatefulWidget{
  List<ApplyEntity> allList = new List<ApplyEntity>();
  List<ApplyEntity> waitList= new List<ApplyEntity>();
  List<ApplyEntity> acceptList= new List<ApplyEntity>();
  List<ApplyEntity> refuseList= new List<ApplyEntity>();

  bool hasAll;
  bool hasWait;
  bool hasAccept;
  bool hasRefuse;
  bool state;

  CheckInfoWidget(this.allList,this.hasAll,this.waitList,this.hasWait,
      this.acceptList,this.hasAccept,this.refuseList,this.hasRefuse,this.state);
  @override
  State<StatefulWidget> createState() {
    return _CheckInfoWidgetState();
  }
}

class _CheckInfoWidgetState extends State<CheckInfoWidget>{
  List<int> mList;
  List<ExpandStateBean> expandStateList;
  _CheckInfoWidgetState(){
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
              child:widget.state? applyListWidget(context,index, index==0?widget.allList:index==1?widget.waitList:
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
            title: Text(index == 0?"全部":index == 1? "待审核":index == 2?"已通过":"未通过",
              style: new TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700
              ),),
          ),
        ),
        index == 0?Container():Positioned(
            left: 65.0,
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
        child:applyOneWidget(context,index, applyList[i]) ,
      ));
    }
    return ListView(
      shrinkWrap: true ,
      children:_list,
    );
  }
}

Widget applyOneWidget(BuildContext context,int index,ApplyEntity applyEntity){
  UserStateModel userStateModel = Provider.of<UserStateModel>(context, listen: false);
  int rol = userStateModel.user.firstPositionId;
  double size = 16;
  return InkWell(
    onTap: (){
      size=20;
      showDetailDialog(context, applyEntity);
    },
    highlightColor: Colors.green,
    child: Column(
      children: [
        Container(
          height: 70.0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              index==0?Row(
                // todo yuyi 这里通过 status和rol和逻辑应收敛到applyEntity / Model中, 通过get方法获取ui需要的信息
                // 另外，对于后台定义的0/1/2（具有意义的常量），工程里应定义成常量并命令
                // 好处：1. ui上不耦合业务逻辑 2. 代码逻辑复用性、可维护性更强 3. 提高代码可读性
                children: [
                  Text('${applyEntity.applicant}   ',
                      style: TextStyle(fontSize:size,color: (applyEntity.status == 0&&rol==2)||(applyEntity.status == 2&&rol==1)?Colors.orange:
                      ( applyEntity.status==2&&rol==2)||(applyEntity.status == 4&&rol==1)?Colors.green:Colors.redAccent)),
                  Text((applyEntity.status == 0&&rol==2)||(applyEntity.status == 2&&rol==1)?"(待审核)":
                  ( applyEntity.status==2&&rol==2)||(applyEntity.status == 4&&rol==1)?"(已通过)":"(未通过)",
                      style: TextStyle(color: (applyEntity.status == 0&&rol==2)||(applyEntity.status == 2&&rol==1)?Colors.orange:
                      ( applyEntity.status==2&&rol==2)||(applyEntity.status == 4&&rol==1)?Colors.green:Colors.redAccent))
                ],
              ):Text('${applyEntity.applicant}',style: TextStyle(fontSize: size),),
              Icon(Icons.keyboard_arrow_right,color: Colors.grey[300],)
            ],
          ),
        ),
        Container(height: 1.0,color:Colors.grey[100],)
      ],
    ),
  );
}

showDetailDialog(BuildContext context,ApplyEntity applyEntity) async{
  UserStateModel userStateModel = Provider.of<UserStateModel>(context, listen: false);
  ApplyStateModel applyStateModel = Provider.of<ApplyStateModel>(context, listen: false);
  int rol = userStateModel.user.firstPositionId;
  int userId = userStateModel.user.id;
  Navigator.push(context,
      MaterialPageRoute(builder: (context) => DetailPage(rol,userId,applyStateModel,applyEntity)));
}