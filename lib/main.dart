import 'package:flutter/material.dart';

import 'ui/loginpage/login.dart';



void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "广东省农业科学院防疫信息系统",
      home: LoginPage(),
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
    );
  }
}
