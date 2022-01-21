import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'data/user_state_model.dart';
import 'ui/loginpage/login.dart';



void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<UserStateModel>( // 注册用户状态管理器，根据用户是否登录进行跳转
        create: (BuildContext context) => UserStateModel()..init(), // 初始化用户状态管理
        child: WillPopScope(
          onWillPop: ()async {
            print("点击返回键");
            Navigator.pop(context);
            return true;
          },
          child: MaterialApp(
            builder: BotToastInit(),
            //配置中文
            localizationsDelegates: [
              //此处
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
            ],
            supportedLocales: [
              //此处
              const Locale('zh', 'CN'),
              const Locale('en', 'US'),
            ],
            locale: Locale('zh'),
            title: "经信所出差审批系统",
            home: LoginPage(),
            navigatorObservers: [BotToastNavigatorObserver()],
            //2.registered route observer
            theme: Theme.of(context).copyWith(
                scaffoldBackgroundColor: Colors.white,
                primaryColorDark: Color(0xff388e3c),
                primaryColorLight: Color(0xffC8E6C9),
                primaryColor: Color(0xff4CAF50),
                accentColor: Color(0xff4CAF50),
                dividerColor: Color(0xbdbdbd),
                iconTheme:
                Theme.of(context).iconTheme.copyWith(color: Color(0xffffffff)),
                textTheme: Theme.of(context).textTheme.copyWith(
                    subtitle1: Theme.of(context)
                        .textTheme
                        .subtitle1
                        .copyWith(fontWeight: FontWeight.w500, fontSize: 18),
                    button: Theme.of(context)
                        .textTheme
                        .button
                        .copyWith(color: Colors.white),
                    subtitle2: Theme.of(context).textTheme.subtitle2.copyWith(
                        color: Colors.grey,
                        fontSize: 20
                    )
                ),
                buttonTheme: Theme.of(context).buttonTheme.copyWith(minWidth: 100),
                buttonBarTheme:
                Theme.of(context).buttonBarTheme.copyWith(buttonMinWidth: 100)),
          ),
        )
    );
  }
}