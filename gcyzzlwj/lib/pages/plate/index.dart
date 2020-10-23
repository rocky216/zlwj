import 'package:flutter/material.dart';
import 'package:gcyzzlwj/components/MyHeader.dart';
import 'package:gcyzzlwj/components/MyList.dart';
import 'package:gcyzzlwj/components/MyScan.dart';
import 'package:gcyzzlwj/utils/index.dart';

class PlatePage extends StatefulWidget {
  PlatePage({Key key}) : super(key: key);

  @override
  _PlatePageState createState() => _PlatePageState();
}

class _PlatePageState extends State<PlatePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyHeader(
        title: "车牌识别",
      ),
      body: Container(
        margin: EdgeInsets.only(top: 50.0),
        width: double.infinity,
        child: Column(
          children: [
            MyScan(
              next: (result){
                scanJump(context, result);
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(30.0)),
                  boxShadow: [
                    BoxShadow(color: Colors.grey, blurRadius: 3.0)
                  ]
                ),
                child: CircleAvatar(
                  radius: 35.0,
                  child: Icon(Icons.crop_free, size: 30.0, color: Colors.white,),
                ),
              ),
            ),
            SizedBox(height: 20.0,),
            Text("停车扫码支付")
          ],
        ),
      ),
    );
  }
}