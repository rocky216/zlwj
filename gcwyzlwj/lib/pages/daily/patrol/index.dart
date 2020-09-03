import 'package:flutter/material.dart';
import 'package:gcwyzlwj/components/MyCard.dart';
import 'package:gcwyzlwj/components/MyHeader.dart';
import 'package:gcwyzlwj/components/MyScrollView.dart';
import 'package:gcwyzlwj/utils/http.dart';

class DailyPatrol extends StatefulWidget {
  DailyPatrol({Key key}) : super(key: key);

  @override
  _DailyPatrolState createState() => _DailyPatrolState();
}

class _DailyPatrolState extends State<DailyPatrol> {
  List data;

  @override
  void initState() { 
    super.initState();
    this.initial();
    this.myPatrol();
  }

  initial() async {
    var data = await NetHttp.request("/api/app/property/ppPatrolLine/", context, params: {});
    
    if(data != null){
      setState(() {
        this.data=data;
      });
    }
  }
  myPatrol() async {
    var data = await NetHttp.request("/api/app/property/ppPatrolRecord/", context, params: {});
    if(data != null){
      
    }
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: MyHeader(
        title: Text("巡更"),
      ),
      body: MyScrollView(
        child: Column(
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
            )
            
          ],
        ),
      ),
    );
  }
}