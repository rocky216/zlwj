import 'package:flutter/material.dart';
import 'package:gcwyzlwj/components/MyAuth.dart';
import 'package:gcwyzlwj/components/MyCard.dart';

class HomeDaily extends StatefulWidget {
  HomeDaily({Key key}) : super(key: key);

  @override
  _HomeDailyState createState() => _HomeDailyState();
}

class _HomeDailyState extends State<HomeDaily> {
  List<Map> list = [
    {"name": "考勤打卡", "color": Color(0xFFf439a3), "link": "/daily/clock", "auth": "1-1"},
    {"name": "车牌查询", "color": Color(0xFFf4cf39), "link": "/daily/plate", "auth": null},
    {"name": "保安巡更", "color": Color(0xFF7b39f4), "link": "/daily/patrol", "auth": null},
    {"name": "空置房巡查", "color": Color(0xFF02a7f0), "link": "/daily/inspect", "auth": null},
    {"name": "打卡设置", "color": Color(0xFFf46e39), "link": "/daily/setclock", "auth": "1-3"},
  ];


  @override
  Widget build(BuildContext context) {
    return MyCard(
      title: Text("日常管理", style: TextStyle(fontWeight: FontWeight.w600),),
      child: Wrap(
        children: list.map((f){
          return MyAuth(
            auth: f["auth"],
            child: Container(
              margin: EdgeInsets.only(bottom: 10),
              child: FlatButton(onPressed: (){
                Navigator.of(context).pushNamed(f["link"]);
              }, 
              child: Column(
                children: <Widget>[
                  CircleAvatar(child: Icon(Icons.cloud, color: Colors.white,), radius: 20, backgroundColor: f["color"],),
                  Text(f["name"], style: TextStyle(fontSize: 11, color: Color(0XFF777777)),)
                ],
              )),
            ),
          );
        }).toList(),
      ),
    );
  }
}