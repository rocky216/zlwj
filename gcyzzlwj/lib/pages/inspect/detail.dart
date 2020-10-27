import 'package:flutter/material.dart';
import 'package:gcyzzlwj/components/MyBigImg.dart';
import 'package:gcyzzlwj/components/MyHeader.dart';
import 'package:gcyzzlwj/components/MyScrollView.dart';
import 'package:gcyzzlwj/utils/http.dart';

class InspectDetailPage extends StatefulWidget {
  final arguments;
  InspectDetailPage({Key key, this.arguments}) : super(key: key);

  @override
  _InspectDetailPageState createState() => _InspectDetailPageState();
}

class _InspectDetailPageState extends State<InspectDetailPage> {
  Map detail;

  @override
  void initState() { 
    super.initState();
    this.initial();
  }

  initial() async {
    var data = await NetHttp.request("/api/app/owner/myJournal/assetsCheckInfo", context, params: {
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
        title: "巡查详情",
      ),
      body: MyScrollView(
        child: detail==null?Container()
        :Column(
          children: [
            Container(
              margin: EdgeInsets.all(10.0),
              padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
              color: Color(0xFFeeeeee),
              child: ListTile(
                title: Text(detail["assetsName"]+detail["assetsCode"]),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('巡查人：'+ detail["checkUserName"]),
                    Text('巡查时间：'+detail["buildTime"]),
                  ],
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(10.0),
              width: double.infinity,
              child: Text(detail["checkInfo"]),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
              width: double.infinity,
              child: Wrap(
                children: (detail["attrList"] as List).map((f) => 
                  Container(
                    margin: EdgeInsets.only(right: 5.0, bottom: 5.0),
                    child: MyBigImg(imgUrl: f["dowloadHttpUrl"], 
                      child: Image.network(f["dowloadHttpUrl"], width: 80, height: 120.0, fit: BoxFit.fill,)
                    ),
                  )
                ).toList(),
              ),
            )
          ],
        ),
      ),
    );
  }
}