import 'package:flutter/material.dart';
import 'package:gcyzzlwj/components/MyBigImg.dart';
import 'package:gcyzzlwj/components/MyHeader.dart';
import 'package:gcyzzlwj/components/MyScrollView.dart';
import 'package:gcyzzlwj/utils/http.dart';


class CleanDetailPage extends StatefulWidget {
  final arguments;
  CleanDetailPage({Key key, this.arguments}) : super(key: key);

  @override
  _CleanDetailPageState createState() => _CleanDetailPageState();
}

class _CleanDetailPageState extends State<CleanDetailPage> {
  Map detail;
  List imgs = [];
  @override
  void initState() { 
    super.initState();
    this.initial();
  }

  initial() async {
    var data = await NetHttp.request("/api/app/owner/myJournal/repairInfo", context, params: {
      "id": widget.arguments["id"].toString()
    });
    if(data != null){
      setState(() {
        this.detail = data;
        this.imgs = data["imgSubUrls"];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyHeader(
        title: "报修详情",
      ),
      body: MyScrollView(
        child: this.detail==null? Container()
        :Container(
          padding: EdgeInsets.only(left: 10.0, right: 10.0),
          child: Column(
            children: <Widget>[
              Text(detail["repairName"], style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20.0),),
              Container(
                margin: EdgeInsets.all(10.0),
                child: Text(detail["buildTime"], style: TextStyle(color: Color(0xFF666666)),),
              ),
              Container(
                child: Text(detail["repairInfo"]),
              ),
              Container(
                padding: EdgeInsets.all(10.0),
                child: Wrap(
                  children: (this.detail["imgSubUrls"] as List).map((f){
                    return Container(
                      margin: EdgeInsets.only(right: 5.0, bottom: 5.0),
                      child: MyBigImg(
                        imgUrl: f, 
                        child: Image.network(f, fit: BoxFit.fill, width: 100.0, height: 150.0,)
                      ),
                    );
                  }).toList(),
                ),
              ),
              Container(
                padding: EdgeInsets.all(10.0),
                child: Wrap(
                  children: (this.detail["imgEndUrls"] as List).map((f){
                    return Container(
                      margin: EdgeInsets.only(right: 5.0, bottom: 5.0),
                      child: MyBigImg(
                        imgUrl: f, 
                        child: Image.network(f, fit: BoxFit.fill, width: 100.0, height: 150.0,)
                      ),
                    );
                  }).toList(),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}