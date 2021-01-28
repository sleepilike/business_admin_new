/// app名字
const String title = 'ncov-2019';

///连接超时时间为5秒
const int connectTimeOut = 10 * 1000;

///响应超时时间为10秒
const int receiveTimeOut = 10 * 1000;

//时间是否超过三天
bool isOver(String _year,String _month,String _day){

  int year = int.parse(_year);
  int month = int.parse(_month);
  int day = int.parse(_day);
  DateTime t = new DateTime(year,month,day);
  DateTime now = new DateTime.now();
  var long = now.difference(t);
  return long.inDays<=3? false : true;
}
