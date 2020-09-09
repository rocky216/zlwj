import 'package:flutter/material.dart';
import 'package:gcwyzlwj/components/MyCard.dart';

class Repair extends StatefulWidget {
  Repair({Key key}) : super(key: key);

  @override
  _RepairState createState() => _RepairState();
}

class _RepairState extends State<Repair> {
  List<Map> list = [
    {"name": "我的报修", "color": Color(0xFFf439a3), "link": "/repair/person"},
    {"name": "全部报修", "color": Color(0xFFf4cf39), "link": "/repair/all"},
  ];

  @override
  Widget build(BuildContext context) {
    return MyCard(
      title: Text("报修管理", style: TextStyle(fontWeight: FontWeight.w600),),
      child: Wrap(
        children: list.map((f){
          return Container(
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
          );
        }).toList(),
      ),
    );
  }
}