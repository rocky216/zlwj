import 'dart:convert';

import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/material.dart';
import 'package:gcwyzlwj/components/MyHeader.dart';
import 'package:gcwyzlwj/components/MyScan.dart';
import 'package:gcwyzlwj/components/MyScrollView.dart';
import 'package:gcwyzlwj/redux/export.dart';
import 'package:gcwyzlwj/utils/http.dart';
import 'package:gcwyzlwj/utils/index.dart';

class PatrolDetail extends StatefulWidget {
  final arguments;
  PatrolDetail({Key key, this.arguments}) : super(key: key);

  @override
  _PatrolDetailState createState() => _PatrolDetailState();
}


class _PatrolDetailState extends State<PatrolDetail> {
  List noCompleted=[];
  List completed=[];
  Map res;
  bool status=false;

  @override
  void initState() { 
    super.initState();
    this.initial();
  }

  initial({id=""}) async {
    var data = await NetHttp.request("/api/app/property/ppPatrolRecordPoint/selectRecordPoint", context, params: {
      "lineId": widget.arguments["id"],
      "recordId": id
    });
    if(data != null){
      
      setState(() {
        this.noCompleted=data["noCompleted"];
        this.completed=data["completed"];
      });
    }
  }

  toCompleted(code) async {
    var url = await uploadImg("camera");
    var data = await NetHttp.request("/api/app/property/ppPatrolRecordPoint/complete", context, method: "post", params: {
      "recordId": "",
      "code": code,
      "imgUrl": url,
      "lineId": widget.arguments["id"],
      "recordId": res == null?"":res["id"]
    });
    if(data != null){
      showToast("巡查成功！");
      initial(id: data["id"]);
      setState(() {
        this.res = data;
      });

    }
  }

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyHeader(
        isHe: true,
        title: Text(widget.arguments["name"])
      ),
      body: MyScrollView(
        child: StoreConnector<IndexState, DailyState>(
          onDispose: (Store store){
            
            store.dispatch( getMyPatrol(context, params: {
              "buildTime": "${widget.arguments['date']} 23:59:59"
            }) );
          },
          converter: (store)=>store.state.daily,
          builder: (BuildContext context, state){
            return Container(
              child: Column(
                children: <Widget>[
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Container(
                          decoration: BoxDecoration(
                              border: Border(bottom: BorderSide(width: 2.0, color:status?Colors.white:Colors.blue))
                            ),
                          child: MaterialButton(onPressed: (){
                            setState(() {
                              status=false;
                            });
                          }, child: Text("未完成", style: TextStyle(color: status?Colors.black:Colors.blue),),),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            border: Border(bottom: BorderSide(width: 2.0, color:!status?Colors.white:Colors.blue))
                          ),
                          child: MaterialButton(onPressed: (){
                            setState(() {
                              status=true;
                            });
                          }, child: Text("已完成", style: TextStyle(color: !status?Colors.black:Colors.blue),),),
                        )
                      ],
                    ),
                  ),
                  Container(
                    child: Column(
                      children: (status?completed:noCompleted).asMap().keys.map((index){
                        return Container(
                          padding: EdgeInsets.all(8.0),
                          decoration: BoxDecoration(border: Border(bottom: BorderSide(width: 3.0, color: Color(0xFFdddddd)))),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Expanded(
                                flex: 3,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text((status?completed:noCompleted)[index]["name"], overflow: TextOverflow.ellipsis, style: TextStyle(color: Colors.blue),),
                                    Text((status?completed:noCompleted)[index]["info"], overflow: TextOverflow.ellipsis, maxLines: 3, style: TextStyle(fontSize: 14.0),)
                                  ],
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: index==0 && !status?MyScan(
                                  child: Column(
                                    children: <Widget>[
                                      const Icon(IconData(0xe606, fontFamily: "AntdIcons"), size: 30, color: Colors.blue,),
                                      Text("扫一扫", style: TextStyle(color: Colors.blue),)
                                    ],
                                  ),
                                  next: (ScanResult result) async {
                                    if(result.rawContent.isNotEmpty){
                                      this.toCompleted(result.rawContent);
                                    }
                                  },
                                ):Container(),
                              )
                            ],
                          ),
                        );
                      }).toList() 
                    ),
                  ),
                  

                  // Container(
                  //   child: Column(
                  //     children: <Widget>[
                  //       Container(
                  //         child: TextField(),
                  //       ),
                  //       Container(
                  //         width: 230.0,
                  //         child: RaisedButton(onPressed: (){

                  //         }, child: Text("强制完结巡更")),
                  //       )
                  //     ],
                  //   ),
                  // )
                ],
              ),
            );
          },
        ),
      )
    );
  }
}