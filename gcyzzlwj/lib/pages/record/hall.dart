import 'package:flutter/material.dart';
import 'package:gcyzzlwj/components/MyHeader.dart';
import 'package:gcyzzlwj/components/MyList.dart';

class HallRecordPage extends StatefulWidget {
  HallRecordPage({Key key}) : super(key: key);

  @override
  _HallRecordPageState createState() => _HallRecordPageState();
}

class _HallRecordPageState extends State<HallRecordPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyHeader(
        title: "投票记录",
      ),
      body: MyList(
        url: "/api/app/owner/myJournal/myRecord", 
        itemBuilder: (dataList, i){
          return ListTile(
            title: Text(dataList[i]["themeName"]),
            subtitle: Container(
              margin: EdgeInsets.only(top: 5.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(dataList[i]["optionName"]),
                  Text('投票时间：'+dataList[i]["buildTime"]),
                  Text('投票数：'+dataList[i]["count"].toString()),
                ],
              ),
            ),
          );
        }
      ),
    );
  }
}