import 'dart:ui';

import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:registration_admin/data/user_state_model.dart';
import 'package:registration_admin/ui/widget/auto_resize_widget.dart';
import 'package:registration_admin/ui/widget/header.dart';

import '../../common/check.dart';
import '../../config/const.dart';
import '../mainpage/mainpage.dart';

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new _LoginPageState();
  }
}

class _LoginPageState extends State<LoginPage> {
  var leftRighthRadding = 30.0;
  var topBottomPadding = 4.0;
  var textTips = new TextStyle(fontSize: 16.0, color: Colors.black);
  var hintTips = new TextStyle(fontSize: 15.0, color: Colors.black26);

  var _userPassController = new TextEditingController();
  var _useNameController = new TextEditingController();

  var _identityIDController = new TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Widget build(BuildContext context) {
    return AutoResizeWidget(
      child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: Consumer<UserStateModel>(
            builder: (BuildContext context, UserStateModel value, Widget child) {
              // 已经登陆，跳转到首页
              if (value.autoLogin) {
                Future.delayed(Duration(milliseconds: 500), (){
                  Navigator.push(
                      context, MaterialPageRoute(builder: (context) => MainPage()));
                });
              }
              return Container(
                child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(
                        height: 30,
                      ),
                      Padding(
                        padding: new EdgeInsets.all(25.0),
                        child: Header(),
                      ),
                      Padding(
                        padding: new EdgeInsets.fromLTRB(
                            10.0, 50.0, leftRighthRadding, 10.0),
                        child: Text(
                          "审核端登录",
                          style:
                          TextStyle(color: Colors.black, fontSize: 30.0),
                        ),
                      ),
                      Form(
                        key: _formKey,
                        child: Column(
                          children: <Widget>[
                            Padding(
                              padding: new EdgeInsets.fromLTRB(leftRighthRadding,
                                  10.0, leftRighthRadding, topBottomPadding),
                              child: TextFormField(
                                validator: (v) =>
                                strNoEmpty(v) ? null : '用户名不能为空',
                                style: hintTips,
                                controller: _identityIDController,
                                decoration: InputDecoration(
                                  labelText: '请输入用户名',
                                  hintText: '您的用户名',
                                  hintStyle: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 13,
                                  ),
                                  prefixIcon: Icon(Icons.person),
                                ),
                                obscureText: false,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: 360.0,
                        margin: new EdgeInsets.fromLTRB(10.0, 20.0, 10.0, 0.0),
                        padding: new EdgeInsets.fromLTRB(
                            leftRighthRadding,
                            topBottomPadding,
                            leftRighthRadding,
                            topBottomPadding),
                        child: new Card(
                          color: Colors.green,
                          elevation: 6.0,
                          child: new FlatButton(
                              onPressed: () => _handleLogin(context),
                              child: new Padding(
                                padding: new EdgeInsets.all(10.00),
                                child: new Text(
                                  "登录",
                                  style: new TextStyle(
                                      color: Colors.white, fontSize: 16.0),
                                ),
                              )),
                        ),
                      )
                    ]),
              );
            },
          )),
    );
  }

  _handleLogin(BuildContext context) {
   /* Navigator.push(
        context, MaterialPageRoute(builder: (context) => MainPage()));*/
    if (_formKey.currentState.validate()) {
      Provider.of<UserStateModel>(context, listen: false)
          .login(_identityIDController.text)
          .then((value) {
        // 登陆成功
        BotToast.showText(text: '登陆成功');
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => MainPage()));
      }).catchError((err) => BotToast.showText(text: '登陆失败，' + err.toString()));
    }
  }
}
