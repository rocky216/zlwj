import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:gcyzzlwj/utils/http.dart';
import '../../components/MyScrollView.dart';
import '../../components/MyHeader.dart';

class GovernDetailPage extends StatefulWidget {
  final arguments;
  GovernDetailPage({Key key, this.arguments}) : super(key: key);

  @override
  _GovernDetailPageState createState() => _GovernDetailPageState();
}

class _GovernDetailPageState extends State<GovernDetailPage> {
  var detail={};

  @override
  void initState() { 
    super.initState();
    this.initial();
  }
  initial() async {
    var data = await NetHttp.request("/api/app/owner/government/${widget.arguments['id']}", context, params: {});
    print(data);
    setState(() {
      this.detail = data;
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyHeader(title: "政务公开详情"),
      body: MyScrollView(
        
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(10.0),
              
              child: Text(this.detail.isNotEmpty?this.detail["title"]:"", 
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20.0)),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 20.0),
              child: Text(this.detail.isNotEmpty?"发布时间："+this.detail["buildTime"]:"", style: TextStyle(color: Color(0xFF666666)),),
            ),
            Html(
              data: this.detail.isNotEmpty?this.detail["content"]:"",
            )
          ],
        ),
      )
    );
  }
}