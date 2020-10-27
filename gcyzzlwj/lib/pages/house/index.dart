import 'package:flutter/material.dart';
import 'package:gcyzzlwj/components/MyHeader.dart';
import 'package:gcyzzlwj/components/MyScrollView.dart';
import 'package:gcyzzlwj/components/MySimpleList.dart';
import 'package:gcyzzlwj/utils/http.dart';

class UserHousePage extends StatefulWidget {
  UserHousePage({Key key}) : super(key: key);

  @override
  _UserHousePageState createState() => _UserHousePageState();
}

class _UserHousePageState extends State<UserHousePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyHeader(
        title: "我的房产",
      ),
      body: MySimpleList(
        url: "/api/app/owner/my/houseInfo", 
        itemBuilder: (dataList, i){
          return ListTile(
            title: Text(dataList[i]["heAssetsCode"]),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("建筑面积：${dataList[i]['houseArea']}平方"),
                Text("资产类型：${dataList[i]["type"]}"),
                Text("缴费区间：${dataList[i]["payment"]}"),
              ],
            ),
          );
        }
      ),
    );
  }
}