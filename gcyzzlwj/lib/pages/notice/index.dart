import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gcyzzlwj/components/MyHeader.dart';
import 'package:gcyzzlwj/config/index.dart';

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
      body: FlatButton(child: Text("点击"),onPressed: (){
        
      },),
    );
  }
}