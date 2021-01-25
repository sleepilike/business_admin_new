
import 'package:flutter/material.dart';
import 'package:registration_admin/config/const.dart';

class Header extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        //Image.asset(LOGO, width: 85, height: 85,),
        Text(
          " 经信所出差审批系统\n出差审批",
          //style: Theme.of(context).textTheme.headline,
          style: new TextStyle(fontSize: 26,fontWeight: FontWeight.w700),
          softWrap: true,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

}