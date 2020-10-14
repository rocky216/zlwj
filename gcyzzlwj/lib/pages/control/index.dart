import 'dart:async';

import 'package:flutter/material.dart';
import 'package:gcyzzlwj/components/MyCard.dart';
import 'package:gcyzzlwj/components/MyHeader.dart';
import 'package:gcyzzlwj/utils/http.dart';

class ControlPage extends StatefulWidget {
  ControlPage({Key key}) : super(key: key);

  @override
  _ControlPageState createState() => _ControlPageState();
}

class _ControlPageState extends State<ControlPage> {
  List doorlist = [];
  @override
  void initState() { 
    super.initState();
    this.initial();
  }
  initial() async {
    var data = await NetHttp.request("/api/app/owner/qr/deviceDoorList", context, params: {});

    if(data != null){
      setState(() {
        this.doorlist = data;
      });
    }
  }
  openDoor(item) async {
    item["times"] = 10;
    setState(() {
      this.doorlist=doorlist;
    });
    item["timer"] = Timer.periodic(Duration(seconds: 1), (t){
      item["times"]--;
      if(item["times"]==0){
        item["times"]=null;
        item["timer"]?.cancel();
      }
      setState(() {
        this.doorlist=doorlist;
      });
    });
    
    
    Map params = {
      "iotId":item["iotId"],
      "openSecond":item["openSecond"].toString(),
      "reader":item["port"].toString(),
    };
    // var data = await NetHttp.request("/controller/remote/open", context,method: "post", params: params);
    
    // if(data != null){
    //   showToast("开门成功");
    // }
  }

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyHeader(
        title: "门禁",
      ),
      body: Container(
        padding: EdgeInsets.all(10.0),
        child: ListView.separated(
          itemBuilder: (context, index){
            return Container(
              child: MyCard(
                title: Text(this.doorlist[index]["doorName"], style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16.0),),
                child: Container(
                  padding: EdgeInsets.all(10.0),
                  alignment: Alignment.center,
                  child: Container(
                    height: 90.0,
                    width: 90.0,
                    child: RaisedButton(
                      color: this.doorlist[index]["times"]==null?Theme.of(context).primaryColor: Colors.grey,
                      child: Text(this.doorlist[index]["times"]==null?"开门":doorlist[index]["times"].toString()+'s', style: TextStyle(color: Colors.white, fontSize: 16.0),),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(50.0))
                      ),
                      onPressed: (){
                        if(this.doorlist[index]["times"]==null){
                          this.openDoor(this.doorlist[index]);
                        }
                      },
                    ),
                  ),
                ),
              ),
            );
          }, 
          separatorBuilder: (context, int index){
            return Container(height: 10.0);
          }, 
          itemCount: this.doorlist.length,
        )
      ),
    );
  }
}