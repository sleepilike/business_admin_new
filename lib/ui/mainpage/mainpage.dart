import 'package:flutter/material.dart';
import 'package:registration_admin/ui/mainpage/mainpagebranch.dart';

class MainPage extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return new _MainPageState();
  }
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "经信所出差审批系统",
      home:MainPageBranch(),
      theme: Theme.of(context).copyWith(
          scaffoldBackgroundColor: Colors.white,
          primaryColorDark: Color(0xff388e3c),
          primaryColorLight: Color(0xffC8E6C9),
          primaryColor: Color(0xff4CAF50),
          accentColor: Color(0xff4CAF50),
          dividerColor: Color(0xbdbdbd),
          iconTheme: Theme.of(context).iconTheme.copyWith(color: Color(0xffffffff)),
          textTheme: Theme.of(context).textTheme.copyWith(
              subtitle: Theme.of(context).textTheme.subtitle.copyWith(
                  fontWeight: FontWeight.w500,
                  fontSize: 18
              ),
              button: Theme.of(context).textTheme.button.copyWith(
                  color: Colors.white
              )
          ),
          buttonTheme: Theme.of(context).buttonTheme.copyWith(
              minWidth: 100
          ),
          buttonBarTheme: Theme.of(context).buttonBarTheme.copyWith(
              buttonMinWidth: 100
          )
      ),
    );
  }
}
