import 'package:flutter/material.dart';
import 'package:gcyzzlwj/components/MyHeader.dart';
import 'package:gcyzzlwj/components/MyList.dart';

class NoticePage extends StatefulWidget {
  NoticePage({Key key}) : super(key: key);

  @override
  _NoticePageState createState() => _NoticePageState();
}

class _NoticePageState extends State<NoticePage> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: MyHeader(title: "小区公告",),
      body: MyList(
        url: "/api/app/owner/common/notice", 
        itemBuilder: (dataList, i){
          return ListTile(
            title: Text(dataList[i]["title"], overflow: TextOverflow.ellipsis, maxLines: 1,),
            subtitle: Text(dataList[i]["content"], overflow: TextOverflow.ellipsis, maxLines: 2,),
            trailing: Icon(Icons.chevron_right, size: 30.0,),
            onTap: (){
              Navigator.of(context).pushNamed("/notice/detail", arguments: dataList[i]);
            },
          );
        }
      ),
    );
  }
}