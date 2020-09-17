import 'dart:async';

import 'package:flutter/material.dart';
import 'package:gcwyzlwj/components/MyHeader.dart';
import 'package:gcwyzlwj/components/MyInput.dart';
import 'package:gcwyzlwj/components/MyScrollView.dart';
import 'package:gcwyzlwj/components/MyUploadImg.dart';
import 'package:gcwyzlwj/redux/export.dart';
import 'package:gcwyzlwj/utils/http.dart';
import 'package:gcwyzlwj/utils/index.dart';


class AddDailyInspect extends StatefulWidget {
  AddDailyInspect({Key key}) : super(key: key);

  @override
  _AddDailyInspectState createState() => _AddDailyInspectState();
}

class _AddDailyInspectState extends State<AddDailyInspect> {
  List imgUrls=[];
  String date = new DateTime.now().toString().substring(0,10);
  String code;
  String info;

  
  myAdd(){
    return Container(
      margin: EdgeInsets.only(left: 10.0),
      child: MyUploadImg(
        next: (url){
          imgUrls.add(url);
          setState(() {
            imgUrls = imgUrls;
          });
        },
        child: Container(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(6.0),
            child: Container(
              width: 60.0,
              height: 60.0,
              color: Color(0xFFdddddd),
              child: Icon(Icons.add, color: Colors.grey, size: 30,),
            ),
          ),
        ),
      ),
    );
  }

  

submit() async {
  var data = await NetHttp.request("/api/app/property/patrol/addCheckRecor", context, method: "post", params: {
    "time": date,
    "code": code,
    "info": info,
    "imgUrls": imgUrls.join(","),
  });
  if(data != null){
    showToast("添加成功！");
    Navigator.of(context).pop();
    StoreProvider.of<IndexState>(context).dispatch( getInspects(context, params: {
      "current": 1,
      "time": "$date 23:59:59",
    }) );
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyHeader(
        isHe: true,
        title: Text("新增空置房巡查"),
        actions: MaterialButton(onPressed: (){
          submit();
        }, child: Text("提交", style: TextStyle(color: Colors.blue),),),
      ),
      body: MyScrollView(
        child: Container(
          child: Column(
            children: <Widget>[
              MyInput(label: Text("巡查时间："), child: Container(
                padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(date),
                    GestureDetector(onTap: () async {
                      DateTime d = await showDatePicker(context: context, initialDate: DateTime.now(), 
                        firstDate: new DateTime.now().subtract(new Duration(days: 365)), // 减 365 天
                        lastDate: new DateTime.now().add(new Duration(days: 365)),
                      );
                      if(d != null){
                        String date = d.toString().substring(0,10);
                        setState(() {
                          this.date = date;
                        });
                      }
                    }, child: Container(
                      padding: EdgeInsets.fromLTRB(10, 0, 20, 0),
                      child: Icon(Icons.date_range, color: Colors.blue, size: 30.0,),
                    ),)
                  ],
                ),
              ),),
              MyInput(
                label: Text("房间编号："), 
                onChange: (v){
                  setState(() {
                    code=v;
                  });
                },
              ),
              MyInput(label: Text("描述情况："), maxLines: 5, padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                onChange: (v){
                  
                  setState(() {
                    info=v;
                  });
                },
              ),
              MyInput(label: Text("选择图片："), 
                child: Wrap(
                  children: imgUrls.map((f){
                    return Container(
                      margin: EdgeInsets.fromLTRB(10.0, 0, 0, 10.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(6.0),
                        child: Container(
                          width: 60.0,
                          height: 60.0,
                          color: Colors.grey,
                          child: Image.network(f, fit: BoxFit.cover),
                        ),
                      ),
                    );
                  }).toList()
                  ..add( myAdd() )
                ),
                padding: EdgeInsets.fromLTRB(0, 10, 0, 10),),
            ],
          ),
        ),
      ),
    );
  }
}