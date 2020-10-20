import 'package:flutter/material.dart';
import 'package:flutter_html/style.dart';
import 'package:gcyzzlwj/components/MyHeader.dart';
import 'package:gcyzzlwj/components/MySimpleList.dart';

class UserPlatePage extends StatefulWidget {
  UserPlatePage({Key key}) : super(key: key);

  @override
  _UserPlatePageState createState() => _UserPlatePageState();
}

class _UserPlatePageState extends State<UserPlatePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyHeader(
        title: "我的车辆",
      ),
      body: MySimpleList(
        url: "/api/app/owner/my/carInfo", 
        itemBuilder: (dataList, i){
          return ListTile(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(dataList[i]["licensePlate"]),
                Text("${dataList[i]['linkName']}(${dataList[i]['linkPhone']})", style: TextStyle(fontSize: 14.0),)
              ],
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: (dataList[i]["carCarCarparks"] as List).map((f) => 
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(f["carparkName"], style: TextStyle(color: Colors.blue),),
                      Text("有效期：${f["validStartTime"].substring(0,10)}到${f["validEndTime"].substring(0,10)}")
                    ],
                  ),
                )
              ).toList(),
            ),
          );
        }
      ),
    );
  }
}