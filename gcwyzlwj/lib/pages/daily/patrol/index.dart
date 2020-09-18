import 'package:flutter/material.dart';
import 'package:gcwyzlwj/components/MyCard.dart';
import 'package:gcwyzlwj/components/MyHeader.dart';
import 'package:gcwyzlwj/components/MyScrollView.dart';
import 'package:gcwyzlwj/redux/daily/middleware.dart';
import 'package:gcwyzlwj/redux/export.dart';
import 'package:gcwyzlwj/utils/http.dart';

class DailyPatrol extends StatefulWidget {
  DailyPatrol({Key key}) : super(key: key);

  @override
  _DailyPatrolState createState() => _DailyPatrolState();
}

class _DailyPatrolState extends State<DailyPatrol> {
  List data;
  List mypatrol;
  String date = new DateTime.now().toString().substring(0,10);

  @override
  void initState() { 
    super.initState();
    this.initial();
  }

  initial() async {
    var data = await NetHttp.request("/api/app/property/ppPatrolLine/", context, params: {});
    
    if(data != null){
      setState(() {
        this.data=data;
      });
    }
  }
  myPatrol(date) {
    StoreProvider.of<IndexState>(context).dispatch( getMyPatrol(context, params: {
      "buildTime": "$date 23:59:59"
    }) );
    // var data = await NetHttp.request("/api/app/property/ppPatrolRecord/", context, params: {
    //   "buildTime": "2020-09-03 23:59:59"
    // });
    // if(data != null){
    //   setState(() {
    //     mypatrol = data;
    //   });
    // }
  }

  Widget getStatus(status){
    switch(status){
      case "0":
        return Row(
          children: <Widget>[ Icon(Icons.brightness_1, size: 14, color: Colors.orange,), Text("巡更中", style: TextStyle(color: Colors.orange),)],
        );
      case "1":
        return Row(
          children: <Widget>[ Icon(Icons.brightness_1, size: 14, color: Colors.blue,), Text("巡更完成", style: TextStyle(color: Colors.blue),)],
        );
      case "2":
        return Row(
          children: <Widget>[ Icon(Icons.brightness_1, size: 14, color: Colors.orange,), Text("强制完成", style: TextStyle(color: Colors.orange),)],
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: MyHeader(
        isHe: true,
        title: Text("巡更"),
        actions: Container(
          width: 60.0,
          child: FlatButton(onPressed: () async {
            DateTime d = await showDatePicker(context: context, initialDate: DateTime.now(), 
              firstDate: new DateTime.now().subtract(new Duration(days: 365)), // 减 365 天
              lastDate: new DateTime.now().add(new Duration(days: 365)),
            );
            if(d != null){
              String date = d.toString().substring(0,10);
              setState(() {
                this.date=date;
              });
              myPatrol(date);
            }
            
          }, child: Icon(Icons.date_range, color: Colors.blue,)),
        ),
      ),
      body: MyScrollView(
        child: StoreConnector<IndexState, List>(
          onInit: (Store store){
            myPatrol(date);
          },
          converter: (store)=>store.state.daily.record,
          builder: (BuildContext context, state){
            return Column(
              children: <Widget>[
                data == null?Container()
                :Card(
                  child: Column(
                    children: data.map((f){
                      return MyCard(
                        title: Row(children: <Widget>[Icon(Icons.dns, size: 16, color: Colors.blue,),Text(f["name"], style: TextStyle(color: Colors.blue),)],),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Container(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(f["info"]),
                                  Text("共有${f["sumPoint"]}个巡更点"),
                                ],
                              ),
                            ),
                            Container(
                              width: 80.0,
                              child: MaterialButton(
                                color: Colors.blue,
                                onPressed: (){
                                  f["date"]=this.date;
                                  Navigator.of(context).pushNamed("/daily/patroldetail", arguments: f);
                                }, 
                                child: Text("开始巡更", style: TextStyle(color: Colors.white, fontSize: 12),),
                              ),
                            )
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                ),

                SizedBox(height: 20.0,),

                state==null?Container()
                :Card(
                  child: Column(
                    children: state.map((f){
                      return MyCard(
                        title: Row(children: <Widget>[Icon(Icons.dns, size: 16, color: Colors.blue,),Text(f["name"], style: TextStyle(color: Colors.blue),)],),
                        extra: getStatus(f["recordStatus"]),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Container(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(f["info"]),
                                  Text("开始：${f["buildTime"]}"),
                                  Text("结束：${f["updateTime"]??''}"),
                                  Text("共有${f["sumPoint"]}个巡更点"),
                                ],
                              ),
                            ),
                            Container(
                              width: 80.0,
                              child: MaterialButton(
                                color: f["recordStatus"]=="0"?Color(0XFFf79844):Colors.blue,
                                onPressed: (){
                                  f["date"]=this.date;
                                  Navigator.of(context).pushNamed("/daily/patrolrecord/detail", arguments: f);
                                }, 
                                child: Text(f["recordStatus"]=="0"?"继续巡更":"查看详情", style: TextStyle(color: Colors.white, fontSize: 12),),
                              ),
                            )
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                )
                
              ],
            );
          },
        ),
      ),
    );
  }
}