import 'dart:async';
import 'package:flutter/material.dart';
import 'package:gcyzzlwj/components/MyHeader.dart';
import 'package:gcyzzlwj/utils/http.dart';
import 'package:gcyzzlwj/utils/index.dart';

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
    item["timer"]?.cancel();
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

    var data = await NetHttp.request("/controller/remote/open", context,method: "post", params: {
      "iotId":item["iotId"],
      "openSecond":item["openSecond"].toString(),
      "reader":item["port"].toString(),
    });
    
    if(data != null){
      showToast("开门成功");
    }
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
          itemBuilder: (context, i){
            return ListTile(
              title: Text(this.doorlist[i]["doorName"]),
              trailing: Container(
                width: 50.0,
                child: MaterialButton(
                  padding: EdgeInsets.zero,
                  color: this.doorlist[i]["times"]==null?Theme.of(context).primaryColor: Colors.grey,
                  child: this.doorlist[i]["times"]==null?Icon(Icons.lock_open, color: Colors.white, size: 20.0,):Text(this.doorlist[i]["times"].toString()+'s'),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(50.0))
                  ),
                  onPressed: (){
                    if(this.doorlist[i]["times"]==null){
                      this.openDoor(this.doorlist[i]);
                    }
                  },
                ),
              ),
            );
          }, 
          separatorBuilder: (context, int index){
            return Container(height: 5.0, color: Color(0xFFeeeeee),);
          }, 
          itemCount: this.doorlist.length,
        )
      ),
    );
  }
}