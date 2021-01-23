import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:registration_admin/data/apply_state_model.dart';
import 'package:registration_admin/data/monitor_state_model.dart';
import 'package:registration_admin/data/user_state_model.dart';
import 'package:registration_admin/ui/dialog/condition_dialog.dart';
import 'package:registration_admin/ui/loginpage/login.dart';
import 'package:registration_admin/ui/mainwidget/imformation.dart';
import 'package:registration_admin/ui/mainwidget/persons.dart';
import 'package:registration_admin/ui/widget/auto_resize_widget.dart';
import 'package:registration_admin/ui/widget/header.dart';
import 'package:url_launcher/url_launcher.dart';

class MainPageBranch extends StatefulWidget {
  @override
  _MainPageBranchState createState() => _MainPageBranchState();
}

class _MainPageBranchState extends State<MainPageBranch> {
  @override
  Widget build(BuildContext context) {
    return AutoResizeWidget(
      child: Scaffold(
        body: Consumer<UserStateModel>(
          builder: (BuildContext context, UserStateModel value, Widget child) {
            int userID = value.user.id;
            return ChangeNotifierProvider<ApplyStateModel>(
              create: (BuildContext context) =>
              ApplyStateModel()..init(userID),
              child: Container(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Flexible(
                      flex: 1,
                      child: ListView(
                        shrinkWrap: true, // 指定自动计算高度
                        children: <Widget>[
                          SizedBox(height: 20,),
                          Header(),
                          SizedBox(height: 20,),
                          Information(),
                          SizedBox(
                            height: 4,
                          ),
                          PersonPage(),
                          SizedBox(
                            height: 4,
                          )
                        ],
                      ),

                    ),
                    Flexible(
                      flex: 0,
                      child: Builder(builder: (context) {
                        return _buildButtonGroup(context);
                      }),
                    )
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  _buildButtonGroup(BuildContext context) {
    return Container(
        width: double.infinity,
        decoration: BoxDecoration(color: Theme.of(context).primaryColor),
        child: ButtonBar(
          children: <Widget>[
            RaisedButton(
              elevation: 4,
              child: Text(
                "退出登录",
                style: Theme.of(context).textTheme.button,
              ),
              color: Color(0xFF087f23),
              onPressed: () => handleLogout(context),
            ),
            SizedBox(
              width: 20,
            ),
          ],
        ));
  }

  handleExportExcel(BuildContext context) {
    MonitorStateModel stateModel =  Provider.of<MonitorStateModel>(context, listen: false);
    if (stateModel.hasMonitorInfo) {
      BotToast.showLoading();
      stateModel.exportExcel().then((value) {
        BotToast.closeAllLoading();
        launch(value);
      }).catchError((err) {
        // 错误
        BotToast.closeAllLoading();
        BotToast.showText(text: '导出excel错误，' + err.toString());
      });
    } else {
      BotToast.showText(text: '该时间段暂无人填报');
    }
  }

  /// 登出
  handleLogout(BuildContext context) {
    Provider.of<UserStateModel>(context, listen: false).logout();
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => LoginPage()));
  }
}
