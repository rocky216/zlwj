import 'dart:convert';

import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/material.dart';
import 'package:gcwyzlwj/components/MyHeader.dart';
import 'package:gcwyzlwj/components/MyScan.dart';
import 'package:gcwyzlwj/components/MyScrollView.dart';
import 'package:gcwyzlwj/redux/export.dart';
import 'package:gcwyzlwj/utils/http.dart';
import 'package:gcwyzlwj/utils/index.dart';

class PatrolRecordDetail extends StatefulWidget {
  final arguments;
  PatrolRecordDetail({Key key, this.arguments}) : super(key: key);

  @override
  _PatrolRecordDetailState createState() => _PatrolRecordDetailState();
}


class _PatrolRecordDetailState extends State<PatrolRecordDetail> {
  List noCompleted=[];
  List completed=[];
  Map res;
  bool status=false;
  String endInfo;

  @override
  void initState() { 
    super.initState();
    this.initial();
  }

  initial() async {
    var data = await NetHttp.request("/api/app/property/ppPatrolRecordPoint/selectRecordPoint", context, params: {
      "recordId": widget.arguments["id"],
    });
    if(data != null){
      setState(() {
        this.noCompleted=data["noCompleted"];
        this.completed=data["completed"];
        status = widget.arguments["recordStatus"]!="0"?true:false;
      });
    }
  }

  toCompleted(code) async {
    var url = await uploadImg("camera");
    var data = await NetHttp.request("/api/app/property/ppPatrolRecordPoint/complete", context, method: "post", params: {
      "recordId": "",
      "code": code,
      "imgUrl": url,
      "recordId": widget.arguments["id"],
    });
    
    if(data != null){
      showToast("巡查成功！");
      initial();
      setState(() {
        this.res = data;
      });

    }
  }

  endSubmit() async {
    if(endInfo==null){
      showToast("填写强制说明！");
      return;
    }
    var data = await NetHttp.request("/api/app/property/ppPatrolRecordPoint/compelCompleted", context, method: "post", params: {
      "recordId": widget.arguments["id"],
      "endInfo": endInfo
    });
    if(data != null){
      showToast("操作成功！");
      Navigator.of(context).pop();
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
          onDispose: (store){
            store.dispatch( getMyPatrol(context, params: {
              "buildTime": "${widget.arguments['date']} 23:59:59"
            }));
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
                            border: Border(bottom: BorderSide(width: 2.0, color: !status?Colors.white:Colors.blue))
                          ),
                          child: MaterialButton(onPressed: (){
                            setState(() {
                              status=true;
                            });
                          }, child: Text("已完成",style: TextStyle(color: !status?Colors.black:Colors.blue),),),
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
                                      Icon(IconData(0xe606, fontFamily: "AntdIcons"), size: 30, color: Colors.blue,),
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
                  
                  widget.arguments["recordStatus"]!="0"?Container()
                  :Container(
                    child: Column(
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.all(10.0),
                          child: TextField(
                            decoration: InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Color(0xFFcccccc), width: 1.0, style: BorderStyle.solid)
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Color(0xFFcccccc), width: 1.0, style: BorderStyle.solid)
                              )
                            ),
                            onChanged: (v){
                              setState(() {
                                endInfo=v;
                              });
                            },
                          ),
                        ),
                        Container(
                          width: 240,
                          color: Color(0xFFee505f),
                          child: MaterialButton(onPressed: (){
                            this.endSubmit();
                          }, child: Text("强制完结巡更", style: TextStyle(color: Colors.white),)),
                        )
                      ],
                    ),
                  )
                ],
              ),
            );
          }, ),
      )
    );
  }
}