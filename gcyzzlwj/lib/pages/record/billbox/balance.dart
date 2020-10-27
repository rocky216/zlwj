import 'package:flutter/material.dart';
import 'package:gcyzzlwj/components/MyList.dart';

class BalanceBillRecord extends StatefulWidget {
  BalanceBillRecord({Key key}) : super(key: key);

  @override
  _BalanceBillRecordState createState() => _BalanceBillRecordState();
}

class _BalanceBillRecordState extends State<BalanceBillRecord>  with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    return MyList(
      url: "/api/app/owner/my/shoppingInfo", 
      params: {
        "type": "balance"
      },
      itemBuilder: (dataList, i){
        
        return ListTile(
          title: Text(dataList[i]["logTypeStr"]),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('创建时间：'+dataList[i]["buildTime"]),
              Text('订单号：'+dataList[i]["linkNo"]),
            ],
          ), 
          trailing: Text((dataList[i]["balanceType"]=="in"?"+ ":"- ") + dataList[i]["updateBalance"].toString(),
            style: TextStyle(color: dataList[i]["balanceType"]=="in"?Colors.green:Colors.red, fontSize: 20.0),),
        );
      }
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}