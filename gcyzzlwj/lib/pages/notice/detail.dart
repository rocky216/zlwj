import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:gcyzzlwj/components/MyHeader.dart';
import 'package:gcyzzlwj/components/MyScrollView.dart';
import 'package:gcyzzlwj/utils/http.dart';

class NoticeDetailPage extends StatefulWidget {
  final arguments;
  NoticeDetailPage({Key key, this.arguments}) : super(key: key);

  @override
  _NoticeDetailPageState createState() => _NoticeDetailPageState();
}

class _NoticeDetailPageState extends State<NoticeDetailPage> {
  Map detail;

  @override
  void initState() { 
    super.initState();
    this.initial();
  }

  initial() async {
    var data = await NetHttp.request("/api/app/owner/common/noticeInfo", context, params: {
      "id": widget.arguments["id"].toString()
    });
    if(data != null){
      setState(() {
        this.detail = data;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyHeader(
        title: "公告详情",
      ),
      body: MyScrollView(
        child: detail==null?Container()
          :Container(
            padding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
            child: Column(
              children: [
                Text(detail["title"], style: TextStyle(fontSize: 20.0),),
                SizedBox(height: 5.0,),
                Text("发布时间："+detail["buildTime"], style: TextStyle(color: Colors.grey),),
                SizedBox(height: 10.0,),
                Html(data: detail["content"])
              ],
            ),
          ),
      ),
    );
  }
}