import 'package:flutter/material.dart';
import 'package:gcwyzlwj/components/MyHeader.dart';
import 'package:gcwyzlwj/components/MyScrollView.dart';
import 'package:gcwyzlwj/utils/http.dart';

class ClockRecord extends StatefulWidget {
  ClockRecord({Key key}) : super(key: key);

  @override
  _ClockRecordState createState() => _ClockRecordState();
}

class _ClockRecordState extends State<ClockRecord> {
  Map data;

  @override
  void initState() { 
    super.initState();
    this.initial(DateTime.now().toString().substring(0,10));
  }

  initial(date) async {
    var data = await NetHttp.request("/api/app/property/clockRecord/list", context, params: {
      "current": 1,
      "pageSize": "20",
      "time": "$date 23:59:59"
    });
    if(data != null){
      setState(() {
        this.data = data;
      });
    }
  }

  Widget getStatus(f){
    String tips="";
    Color color = Colors.black;
    switch(f["clockStatus"]){
      case "0":
        color=Colors.orange;
        tips="等待打卡";
        break;
      case "1":
        color=Colors.red;
        tips="缺卡";
        break;
      case "2":
        color=Colors.red;
        tips="缺卡";
        break;
      case "3":
        color=Colors.blue;
        break;
    }
    return Container(
            margin: EdgeInsets.only(bottom: 8.0),
            child: Row(
              children: <Widget>[
                Icon(Icons.brightness_1, size: 12, color: color,),
                Container(
                  width: 120.0,
                  margin: EdgeInsets.only(left: 10.0),
                  child: Row(children: <Widget>[
                    Container(
                      padding: EdgeInsets.fromLTRB(5.0, 0, 5.0, 0),
                      color: Colors.blue,
                      child: Text("上班卡", style: TextStyle(color: Colors.white, fontSize: 12.0),),
                    ),
                    f["startClockTime"]!=null?Text(f["startClockTime"].substring(11)):Text(tips, style: TextStyle(color: color, fontSize: 12),)
                  ],),
                ),
                Container(
                  margin: EdgeInsets.only(left: 20),
                  child: Row(children: <Widget>[
                    Container(
                      padding: EdgeInsets.fromLTRB(5.0, 0, 5.0, 0),
                      color: Colors.blue,
                      child: Text("下班卡", style: TextStyle(color: Colors.white, fontSize: 12.0),),
                    ),
                    f["endClockTime"]!=null?Text(f["endClockTime"].substring(11)):Text(tips, style: TextStyle(color: color, fontSize: 12),)
                  ],),
                ),
              ],
            ),
          );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyHeader(
        title: Text("考勤记录"),
        actions: Container(
          width: 60.0,
          child: FlatButton(onPressed: () async {
            DateTime d = await showDatePicker(context: context, initialDate: DateTime.now(), 
              firstDate: new DateTime.now().subtract(new Duration(days: 365)), // 减 365 天
              lastDate: DateTime.now(),
            );
            if(d != null){{
              String date = d.toString().substring(0,10);
              initial(date);
            }}
            
          }, child: Icon(Icons.date_range, color: Colors.blue,)),
        ),
      ),
      body: MyScrollView(
        child: Container(
          padding: EdgeInsets.all(10.0),
          child: Column(
            children: <Widget>[
              Container(
                child: Column(
                  children: data==null || data.isEmpty?[]
                  :(data["heClockRecords"] as List).map((f){
                    return getStatus(f);
                  }).toList(),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}