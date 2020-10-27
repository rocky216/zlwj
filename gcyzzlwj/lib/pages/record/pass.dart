import 'package:flutter/material.dart';
import 'package:gcyzzlwj/components/MyHeader.dart';
import 'package:gcyzzlwj/components/MyList.dart';

class PassRecordPage extends StatefulWidget {
  PassRecordPage({Key key}) : super(key: key);

  @override
  _PassRecordPageState createState() => _PassRecordPageState();
}

class _PassRecordPageState extends State<PassRecordPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyHeader(
        title: "通行记录",
      ),
      body: MyList(
        url: "/api/app/owner/myJournal/myPassLog", 
        itemBuilder: (dataList, i){
          return ListTile(
            title: Text(dataList[i]["passDoorName"]),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(dataList[i]["passContent"]),
                Text('通行时间：'+dataList[i]["buildTime"]),
              ],
            ),
          );
        }
      ),
    );
  }
}