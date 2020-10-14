import 'package:flutter/material.dart';
import 'package:gcyzzlwj/components/MyHeader.dart';
import 'package:gcyzzlwj/components/MyList.dart';

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
      body: MyList(
        url: "/api/app/owner/user/license",
        itemBuilder: (dataList, index){
          return ListTile(
            title: Text(dataList[index]["licensePlate"]),
            subtitle: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text("手机号:"+dataList[index]["linkPhone"]),
                Text("联系人:"+dataList[index]["linkName"]),
              ],
            ),
          );
        },
      ),
    );
  }
}