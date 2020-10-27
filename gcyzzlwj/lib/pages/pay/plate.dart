import 'package:flutter/material.dart';
import 'package:gcyzzlwj/components/MyCard.dart';
import 'package:gcyzzlwj/components/MyHeader.dart';
import 'package:gcyzzlwj/components/MyPay.dart';
import 'package:gcyzzlwj/components/MyScrollView.dart';
import 'package:gcyzzlwj/utils/http.dart';

class PayPlatePage extends StatefulWidget {
  final arguments;
  PayPlatePage({Key key, this.arguments}) : super(key: key);

  @override
  _PayPlatePageState createState() => _PayPlatePageState();
}

class _PayPlatePageState extends State<PayPlatePage> {
  Map info;
  bool btn = true;

  @override
  void initState() { 
    super.initState();
    this.initial();
  }

  initial() async {
    var data = await NetHttp.request("/api/app/owner/power/selectPowerPortList", context, params: {
      "url": widget.arguments["content"],
    });
    if(data != null){
      setState(() {
        this.info = data;
      });
    }else{
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyHeader(
        title: this.info==null?"": this.info["carpark"]["carparkName"] ,
      ),
      body: MyScrollView(
        child:  this.info==null? Container() 
        :Column(
          children: [
            Container(
              width: double.infinity,
              padding: EdgeInsets.only(left: 30.0, top: 30.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("车牌号码: ${this.info['record']['license']}", style: TextStyle(fontSize: 20.0, color: Colors.blue),),
                  SizedBox(height: 20.0,),
                  Text("入场时间: ${this.info['record']['iTime']}", style: TextStyle(fontSize: 16.0)),
                  SizedBox(height: 5.0,),
                  Text("出场时间: ${this.info['record']['oTime']}", style: TextStyle(fontSize: 16.0)),
                  SizedBox(height: 5.0,),
                  Text("订单金额: ${this.info['record']['money']}元", style: TextStyle(fontSize: 16.0, color: Colors.red)),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 30.0),
              child: MyPay(
                disabled: !this.btn,
                next: (){
                  setState(() {
                    this.btn = false;
                  });
                },
                params: {
                  "payment": this.info['record']['money'],
                  "orderId": this.info["record"]["id"],
                  "type": "plate"
                },
                child: Container(
                  margin: EdgeInsets.only(bottom: 20.0),
                  decoration: BoxDecoration(
                    color: this.btn? Colors.blue : Colors.grey,
                  ),
                  padding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                  child:Text("支付并创建充电订单", style: TextStyle(color: Colors.white),),
                ),
              ),
            ),
            SizedBox(height: 30.0,),
            MyCard(
              title: Text("收费标准"),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: (this.info["configList"] as List).map((f) => 
                  Padding(padding: EdgeInsets.only(bottom: 5.0),
                    child: Text(f, style: TextStyle(fontSize: 16.0, color: Color(0xFF666666)),),
                  )
                ).toList(),
              ),
            ),
            
          ],
        ),
      ),
    );
  }
}