import 'package:flutter/material.dart';
import 'package:gcyzzlwj/components/MyList.dart';

class IntegralBillRecord extends StatefulWidget {
  IntegralBillRecord({Key key}) : super(key: key);

  @override
  _IntegralBillRecordState createState() => _IntegralBillRecordState();
}

class _IntegralBillRecordState extends State<IntegralBillRecord> with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    return MyList(
      url: "/api/app/owner/my/shoppingInfo", 
      params: {
        "type": "integral"
      },
      itemBuilder: (dataList, i){
        print(dataList[i]["updateScore"]);
        return ListTile(
          title: Text(dataList[i]["logTypeStr"]),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('创建时间：'+dataList[i]["buildTime"]),
              Text('订单号：'+dataList[i]["linkNo"]),
            ],
          ),
          trailing:  Text("${dataList[i]["scoreType"]=="in"?"+ ":"- "}${dataList[i]["updateScore"].toString()}" ,
            style: TextStyle(color: dataList[i]["scoreType"]=="in"?Colors.green:Colors.red, fontSize: 20.0),),
        );
      }
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}