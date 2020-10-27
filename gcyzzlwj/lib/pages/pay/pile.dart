import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:gcyzzlwj/components/MyCard.dart';
import 'package:gcyzzlwj/components/MyHeader.dart';
import 'package:gcyzzlwj/components/MyPay.dart';
import 'package:gcyzzlwj/components/MyRadio.dart';
import 'package:gcyzzlwj/components/MyScrollView.dart';
import 'package:gcyzzlwj/config/index.dart';
import 'package:gcyzzlwj/utils/http.dart';
import 'package:gcyzzlwj/utils/index.dart';

class PayPilePage extends StatefulWidget {
  final arguments;
  PayPilePage({Key key, this.arguments}) : super(key: key);

  @override
  _PayPilePageState createState() => _PayPilePageState();
}

class _PayPilePageState extends State<PayPilePage> {

  int paymode=1;
  Map info;
  int portIndex=0;
  int timeIndex = 0;
  Timer timer;
  bool btn = true;

  @override
  void initState() { 
    super.initState();
    initial();
    print("object");
  }

  @override
  dispose(){
    super.dispose();
    timer?.cancel();
    EasyLoading.dismiss();
  }

  initial() async {
    var data = await NetHttp.request("/api/app/owner/power/selectPowerPortList", context, params: {
      "url": widget.arguments["content"],
    });
    if(data != null){
      setState(() {
        this.info = data;
        this.portIndex = data["selectPort"];
      });
    }else{
      Navigator.of(context).pop();
    }
  }

  noWechatPay() async {
    var data = await NetHttp.request("/api/app/owner/order/loosePay", context, params: {
      "payment": this.info["rates"][this.timeIndex]["money"],
      "deviceId": this.info["portList"][this.portIndex]["powerId"],
      "port": this.info["portList"][this.portIndex]["port"].toString(),
      "payType": this.paymode==2?"balance":this.paymode==3?"score":""
    });
    if(data != null){
      this.trackIsStart();
    }
  }

  trackIsStart() {
    setState(() {
      this.btn = false;
    });
    timer = Timer(Duration(seconds: 3), () async {
      var data = await NetHttp.request("/api/app/owner/power/trackPowerOrder", context, params: {
        "deviceId": this.info["portList"][this.portIndex]["powerId"].toString(),
        "port": this.info["portList"][this.portIndex]["port"].toString(),
      });
      if(data != null){
        Navigator.of(context).pushNamed("/pile/order");
      }
    });

    
  }

  @override
  Widget build(BuildContext context) {
    print(this.portIndex);
    return Scaffold(
      appBar: MyHeader(
        title: info==null?"":info["deviceName"],
      ),
      body: MyScrollView(
        child: info==null?Container()
         :Column(
          children: [
            MyCard(
              title: Text("IOT-NO:${info['deviceSerial']}"),
              extra: Text("端口数：${info['portSize']}"),
              child: Wrap(
                children: (info["portList"] as List).asMap().keys.map((i){
                  List dataList = info["portList"];
                  return GestureDetector(
                    onTap: (){
                      if(dataList[i]['type']=="0"){
                        setState(() {
                          this.portIndex = i;
                        });
                      }
                    },
                    child: Stack(
                      children: [
                        Container(
                          width: 100.0,
                          margin: EdgeInsets.only(right: 10.0),
                          padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                          decoration: BoxDecoration(
                            border: Border.all(color: this.portIndex == i?Colors.blue : Colors.grey, 
                              width: this.portIndex == i?1.5: 1.0)
                          ),
                          child: Column(
                            children: [
                              Text("端口${dataList[i]['port']+1}", style: TextStyle(color: this.portIndex == i?Colors.blue:Colors.black),),
                              dataList[i]['type']=="0"?Text("空闲", style: TextStyle(color: Colors.green),)
                              :Text("使用中", style: TextStyle(color: Colors.orange),)
                            ],
                          ),
                        ),
                        
                        Positioned(
                          right: 10.0,
                          top: 0,
                          child: this.portIndex == i?
                            const Icon( IconData(0xe697, fontFamily: "AntdIcons"), color: Colors.blue,)
                            :Container(),
                        )
                      ],
                    ),
                  );
                }).toList(),
              ),
            ),
            SizedBox(height: 10.0,),
            MyCard(
              title: Text("充电时长"),
              extra: Text(info["chargRules"]),
              child: Wrap(
                children: (info["rates"] as List).asMap().keys.map((i){
                  var dataList = info["rates"];
                  return GestureDetector(
                    onTap: (){
                      setState(() {
                        this.timeIndex = i;
                      });
                    },
                    child: Stack(
                      children: [
                        Container(
                          margin: EdgeInsets.only(right: 10.0, bottom: 10.0),
                          width: 100.0,
                          padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                          decoration: BoxDecoration(
                            border: Border.all(color: this.timeIndex == i?Colors.blue : Colors.grey, 
                                width: this.timeIndex == i?1.5: 1.0)
                          ),
                          child: Column(
                            children: [
                              Text("${dataList[i]['minute']}分钟"),
                              Text("(${dataList[i]['hour']}小时)")
                            ],
                          ),
                        ),
                        Positioned(
                          right: 10.0,
                          top: 0,
                          child: this.timeIndex == i?
                            const Icon( IconData(0xe697, fontFamily: "AntdIcons"), color: Colors.blue,)
                            :Container(),
                        )
                      ],
                    ),
                  );
                }).toList(),
              ),
            ),
            SizedBox(height: 10.0,),
            MyCard(
              title: Text("支付方式"),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("订单金额 ${info['rates'][this.timeIndex]['money']} 元"),
                  MyRadio(value: 1, groupValue: this.paymode, onChanged: (v){
                    setState(() {
                      this.paymode = v;
                    });
                  }, title: Text("微信支付"),),
                  MyRadio(value: 2, groupValue: this.paymode, onChanged: (v){
                    setState(() {
                      this.paymode = v;
                    });
                  }, title: Text("余额支付  (可用余额 ${info['balance']}元)"),),
                  MyRadio(value: 3, groupValue: this.paymode, onChanged: (v){
                    setState(() {
                      this.paymode = v;
                    });
                  }, title: Text("积分支付  (可用积分${info['score']})"),),
                ],
              ),
            ),
            SizedBox(height: 10.0,),
            this.paymode==1?
            MyPay(
              disabled: !this.btn,
              next: (){
                this.trackIsStart();
              },
              params: {
                "payment": info["rates"][this.timeIndex]["money"],
                "deviceId": info["portList"][this.portIndex]["powerId"].toString(),
                "port": info["portList"][this.portIndex]["port"].toString(),
                "type": widget.arguments["type"]
              },
              child: Container(
                margin: EdgeInsets.only(bottom: 20.0),
                decoration: BoxDecoration(
                  color: this.btn? Colors.blue : Colors.grey,
                ),
                padding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                child:Text("支付并创建充电订单", style: TextStyle(color: Colors.white),),
              ),
            )
            : GestureDetector(
              onTap: (){
                if(this.btn){
                  this.noWechatPay();
                }
                
              },
              child: Container(
                margin: EdgeInsets.only(bottom: 20.0),
                decoration: BoxDecoration(
                  color: this.btn? Colors.blue : Colors.grey,
                ),
                padding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                child:Text("支付并创建充电订单", style: TextStyle(color: Colors.white),),
              ),
            )
          ],
        ),
      ),
    );
  }
}