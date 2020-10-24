import 'package:flutter/material.dart';
import 'package:gcyzzlwj/components/MyHeader.dart';
import 'package:gcyzzlwj/components/MyScan.dart';
import 'package:gcyzzlwj/components/MyScrollView.dart';
import 'package:gcyzzlwj/utils/http.dart';
import 'package:gcyzzlwj/utils/index.dart';
import 'package:url_launcher/url_launcher.dart';

class PilePage extends StatefulWidget {
  PilePage({Key key}) : super(key: key);

  @override
  _PilePageState createState() => _PilePageState();
}

class _PilePageState extends State<PilePage> {
  Map detail;

  @override
  void initState() { 
    super.initState();
    this.initial();
  }

  initial() async {
    var data = await NetHttp.request("/api/app/owner/power/getPowerInfo", context, params: {});
    
    if(data != null){
      setState(() {
        this.detail = data;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyHeader(
        title: "智能充电桩",
        actions: FlatButton(
          onPressed: (){
            Navigator.of(context).pushNamed("/pile/order");
          },
          child: Text("充电订单", style: TextStyle(color: Colors.blue),),
        ),
      ),
      body: detail==null?Container()
      :MyScrollView(
        child: !detail["dlag"]?Container(
          width: double.infinity,
          margin: EdgeInsets.only(top: 50.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.error, color: Colors.red, size:40.0,),
              SizedBox(height: 10.0,),
              Text("无法使用智能充电桩功能"),
              SizedBox(height: 5.0,),
              Text("该小区暂未安装智能充电桩"),
            ],
          )
        )
        :Column(
          children: [
            Container(
              margin: EdgeInsets.only(top: 10.0),
              child: ListTile(
                leading: Icon(Icons.attach_money, color: Colors.green,),
                title: Text("使用智联万家APP启动充电", style: TextStyle(color: Colors.green),),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: (detail["rates"] as List).map((f) => 
                    Text("${f['money']}元 = ${f['minute']}分钟" , style: TextStyle(color: Colors.green),)
                  ).toList(),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 10.0),
              child: ListTile(
                leading: Icon(Icons.announcement, color: Colors.blue,),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: (detail["info"] as List).map((f) => 
                    Text(f , style: TextStyle(color: Colors.blue),)
                  ).toList(),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 10.0),
              child: ListTile(
                leading: Icon(Icons.error_outline_outlined, color: Colors.orange,),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: (detail["linkWe"] as List).map((f) => 
                    Text(f , style: TextStyle(color: Colors.orange),)
                  ).toList(),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 10.0),
              child: ListTile(
                leading: Icon(Icons.phone, color: Colors.red,),
                title: Text("咨询热线：${detail["phone"]}", style: TextStyle(color: Colors.red, fontSize: 18.0),),
                onTap: () async {
                  var url = "tel:${detail["phone"]}";
                  if (await canLaunch(url)) {
                    await launch(url);
                  } else {
                    throw 'Could not launch $url';
                  }
                },
              ),
            ),

            MyScan(
              next: (result){
                scanJump(context, result);
              },
              child: Container(
                margin: EdgeInsets.only(top: 10.0, bottom: 20.0),
                padding: EdgeInsets.fromLTRB(30.0, 10.0, 30.0, 10.0),
                decoration: BoxDecoration(
                  color: Colors.blue,
                ),
                child: Text("扫一扫(充电桩二维码)", style: TextStyle(color: Colors.white),),
              ),
            )
          ],
        ),
      ),
    );
  }
}