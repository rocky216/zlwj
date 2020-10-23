import 'package:flutter/material.dart';
import 'package:gcyzzlwj/components/MyHeader.dart';
import 'package:gcyzzlwj/components/MyList.dart';

class PlateOrdersPage extends StatefulWidget {
  PlateOrdersPage({Key key}) : super(key: key);

  @override
  _PlateOrdersPageState createState() => _PlateOrdersPageState();
}

class _PlateOrdersPageState extends State<PlateOrdersPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyHeader(
        title: "停车订单",
      ),
      body: MyList(
        url: "/api/app/owner/myJournal/plateRecord", 
        itemBuilder: (dataList, i){
          return ListTile(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(dataList[i]["parkName"]),
                Text(dataList[i]["truePayFee"].toString()+'元', style: TextStyle(color: Colors.red),),
              ],
            ),
            subtitle: Container(
              margin: EdgeInsets.only(top: 5.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(dataList[i]["license"], style: TextStyle(color: Colors.blue),),
                  Text('进入时间：'+ dataList[i]["iTime"]??"暂无"),
                  Text('离开时间：${dataList[i]["oTime"]??"暂无"}' ),
                  Text('停车时长：'+dataList[i]["recordTimeStr"]),
                ],
              ),
            ),
          );
        }
      ),
    );
  }
}