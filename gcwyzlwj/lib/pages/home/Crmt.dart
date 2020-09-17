import 'package:flutter/material.dart';
import 'package:gcwyzlwj/components/MyAuth.dart';
import 'package:gcwyzlwj/components/MyCard.dart';

class HomeCrmt extends StatefulWidget {
  HomeCrmt({Key key}) : super(key: key);

  @override
  _HomeCrmtState createState() => _HomeCrmtState();
}

class _HomeCrmtState extends State<HomeCrmt> {
  List<Map> list = [
    {"name": "物业费订单", "color": Color(0xFF02a7f0), "link": "/crmt/fee", "auth": "2-1"},
    {"name": "其他支出", "color": Color(0xFFf59a23), "link": "/crmt/expend", "auth": "2-2"},
    {"name": "其他收入", "color": Color(0xFF00bfbf), "link": "/crmt/income", "auth": "2-3"},
    {"name": "物业费待审核", "color": Color(0xFFd9001b), "link": "/crmt/examerr", "auth": "2-4"},
    {"name": "审核支出", "color": Color(0xFF1a00d9), "link": "/crmt/examexpend", "auth": "2-5"},
    {"name": "其他收入待审核", "color": Color(0xFF02a7f0), "link": "/crmt/examincome", "auth": "2-6"},
  ];


  @override
  Widget build(BuildContext context) {
    return MyCard(
      title: Container(child: Text("收支管理", style: TextStyle(fontWeight: FontWeight.w600),), 
        padding: EdgeInsets.all(2),),
      child: Wrap(
        children: list.map((f){
          return MyAuth(
            auth: f["auth"],
            child: Container(
              margin: EdgeInsets.only(bottom: 10),
              child: FlatButton(onPressed: (){
                Navigator.of(context).pushNamed(f["link"], arguments: f);
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