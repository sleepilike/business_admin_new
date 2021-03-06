
import 'package:auto_size_text/auto_size_text.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:registration_admin/data/apply_state_model.dart';
import 'package:registration_admin/data/user_state_model.dart';
import 'package:registration_admin/entity/apply_entity.dart';
import 'package:registration_admin/entity/user_entity.dart';
import 'package:registration_admin/ui/widget/auto_resize_widget.dart';

//审核页面
class DetailPage extends StatefulWidget {
  int rol;
  int userId;
  ApplyStateModel applyStateModel;
  ApplyEntity applyEntity;
  DetailPage(this.rol,this.userId,this.applyStateModel,this.applyEntity);
  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  
  @override
  Widget build(BuildContext context) {
    return Consumer<UserStateModel>(builder: (BuildContext context,UserStateModel value,Widget child){
      String start = widget.applyEntity.startTime.substring(0,10);
      List startsp = start.split("-");
      String end = widget.applyEntity.endTime.substring(0,10);
      List endsp = end.split("-");
      String apply = widget.applyEntity.applyTime.substring(0,10);
      List applysp = apply.split("-");


      return WillPopScope(
        onWillPop: ()async {
          print("点击返回键");
          Navigator.pop(context);
          return true;
        },
        child: AutoResizeWidget(
          child: Scaffold(
            //type:MaterialType.transparency,
            body: SizedBox(
              child: Container(

                color: Colors.white,
                width: double.infinity,
                child:Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 20.0),
                      padding: EdgeInsets.only(left: 10.0,right: 10.0,top: 10.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text((widget.applyEntity.status==0&&widget.rol==2)||(widget.applyEntity.status==2&&widget.rol==1)?'待我审核':
                          (widget.applyEntity.status==2&&widget.rol==2)||(widget.applyEntity.status==4&&widget.rol==1)?"我已同意":"我不同意",
                            style: TextStyle(color: Theme.of(context).primaryColor,fontSize: 18.0,fontWeight: FontWeight.w700),),
                          IconButton(
                            icon: Icon(Icons.close),
                            color: Theme.of(context).primaryColor,
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          )
                        ],
                      ),
                    ),
                    Expanded(
                      child: ListView(
                        shrinkWrap: true,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              info(Icons.person, "申请人", widget.applyEntity.applicant),
                              info(Icons.star, "出差原因", widget.applyEntity.reason),
                              info(Icons.person, "随行人员", widget.applyEntity.accompany),
                              info(Icons.attach_money, "经费来源", widget.applyEntity.fundsFrom),
                              info(Icons.timer, "出发时间", "${startsp[0]}年${startsp[1]}月${startsp[2]}日"),
                              info(Icons.timer, "结束时间", "${endsp[0]}年${endsp[1]}月${endsp[2]}日"),
                              info(Icons.place, "出发地", widget.applyEntity.departure),
                              info(Icons.place, "目的地", widget.applyEntity.destination),
                              info(Icons.directions_bus, "交通方式", widget.applyEntity.transport==null?"无":widget.applyEntity.transport),
                              info(Icons.directions_bus, "超标原因", widget.applyEntity.transportBeyond==null?"无":widget.applyEntity.transportBeyond),
                              lastStatusWidget(widget.applyEntity),
                              currentStatusWidget(widget.applyEntity),
                              info(Icons.timer, "提交时间", "${applysp[0]}年${applysp[1]}月${applysp[2]}日"),

                            ],
                          )
                        ],
                      ),
                    ),

                    (widget.applyEntity.status==0&&widget.rol==2)||
                        (widget.applyEntity.status==3&&widget.rol==1)||
                        (widget.applyEntity.status==2&&widget.rol==1)?Container(
                      width: double.infinity,
                      decoration: BoxDecoration(color: Theme.of(context).primaryColor),
                      child: ButtonBar(
                        children: [
                          RaisedButton(
                            elevation: 4,
                            child: Text('不同意',style: Theme.of(context).textTheme.button,),
                            color: Color(0xFF087f23),
                            onPressed: () => _handleCheck(context, 1),
                          ),
                          RaisedButton(
                            elevation: 4,
                            child: Text('同意',style: Theme.of(context).textTheme.button,),
                            color: Color(0xFF087f23),
                            onPressed: () => _handleCheck(context, 0),
                          )
                        ],
                      ),
                    ):Container(),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    },);
  }
  Widget info(IconData iconData,String title,String info){
    return Container(
      padding: EdgeInsets.all(10.0),
      height: 50.0,
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              //Container(width: 10.0,),
              Container(width: 20.0,child: Icon(iconData,color: Colors.grey,size: 20,),),
              Container(width: 10.0,),
              Container(
                child: Text('${title}',style: TextStyle(fontSize: 18),),
              ),
            ],
          ),
          Container(
              width: 230.0,
              alignment: Alignment.centerRight,
              child:AutoSizeText("${info} ",style: TextStyle(color: Colors.grey,fontSize: 18),maxLines: 2,)
          )
        ],
      ),
    );
  }

  //上一个状态 组件
  Widget lastStatusWidget(ApplyEntity applyEntity){
    return Container(
      padding: EdgeInsets.all(10.0),
      height: 50.0,
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              //Container(width: 10.0,),
              Container(width: 20.0,child: Icon(Icons.check,color: Colors.grey,size: 18,),),
              Container(width: 10.0,),
              Container(
                child: Text('上一状态',style: TextStyle(fontSize: 18),),
              ),
            ],
          ),
          //根据该审批单状态
          applyEntity.status==0?Container(child: Row(
            children: [
              Text("等待",style: TextStyle(color: Colors.grey,fontSize: 18),),
              Text(" ${applyEntity.advise} ",style: TextStyle(color: Theme.of(context).primaryColor,fontSize: 18),),
              Text("审核 ",style: TextStyle(color: Colors.grey,fontSize: 18),),
            ],
          ),):applyEntity.status==2?Container(child: Row(
            children: [
              Text("已通过",style: TextStyle(color: Colors.grey,fontSize: 18),),
              Text(" ${applyEntity.advise} ",style: TextStyle(color: Colors.redAccent,fontSize: 18,),),
              Text("审核 ",style: TextStyle(color: Colors.grey,fontSize: 18),),
            ],
          ),):applyEntity.status==3?Container(child: Row(
            children: [
              Text(" ${applyEntity.advise} ",style: TextStyle(color:  Colors.redAccent,fontSize: 18),),
              Text("审核未通过 ",style: TextStyle(color: Colors.grey,fontSize: 18),),
            ],
          ),):applyEntity.status==4?Container(child: Row(
            children: [
              Text("已通过",style: TextStyle(color: Colors.grey,fontSize: 18),),
              Text(" ${applyEntity.approval} ",style: TextStyle(color:  Colors.redAccent,fontSize: 18),),
              Text("审核 ",style: TextStyle(color: Colors.grey,fontSize: 18),),
            ],
          ),):Container(child: Row(
            children: [
              Text(" ${applyEntity.advise} ",style: TextStyle(color:  Colors.redAccent,fontSize: 18),),
              Text("审核未通过 ",style: TextStyle(color: Colors.grey,fontSize: 18),),
            ],
          ),)
        ],
      ),
    );
  }

  //当前状态组件
  Widget currentStatusWidget(ApplyEntity applyEntity){
    return Container(
      padding: EdgeInsets.all(10.0),
      height: 50.0,
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              //Container(width: 10.0,),
              Container(width: 20.0,child: Icon(Icons.check,color: Colors.grey,size: 18,),),
              Container(width: 10.0,),
              Container(
                child: Text('当前状态',style: TextStyle(fontSize: 18),),
              ),
            ],
          ),
          applyEntity.status==0?Container(child: Row(
            children: [
              Text("等待",style: TextStyle(color: Colors.grey,fontSize: 18),),
              Text(" ${applyEntity.advise} ",style: TextStyle(color: Colors.orange,fontSize: 18),),
              Text("审核 ",style: TextStyle(color: Colors.grey,fontSize: 18),),
            ],
          ),):applyEntity.status==2?Container(child: Row(
            children: [
              Text("等待",style: TextStyle(color: Colors.grey,fontSize: 18),),
              Text(" ${applyEntity.approval} ",style: TextStyle(color:  Colors.orange,fontSize: 18),),
              Text("审核 ",style: TextStyle(color: Colors.grey,fontSize: 18),),
            ],
          ),):applyEntity.status==3?Container(child: Row(
            children: [
              Text("等待",style: TextStyle(color: Colors.grey,fontSize: 18),),
              Text(" ${applyEntity.approval} ",style: TextStyle(color:  Colors.orange,fontSize: 18),),
              Text("审核 ",style: TextStyle(color: Colors.grey,fontSize: 18),),
            ],
          ),):applyEntity.status==4?Container(child: Row(
            children: [
              Text("审核成功 ",style: TextStyle(color: Colors.grey,fontSize: 18),),
            ],
          ),):Container(child: Row(
            children: [
              Text("审核失败 ",style: TextStyle(color: Colors.grey,fontSize: 18),),
            ],
          ),)
        ],
      ),
    );
  }

  _handleCheck(BuildContext context,int type)async{
    BotToast.showLoading();
    await widget.applyStateModel.check(widget.applyEntity.id, type, widget.userId).then((value){
      BotToast.closeAllLoading();
      BotToast.showText(text: '提交成功');
      Navigator.pop(context);
    });
  }
}

