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
                child: Column(
                  children: imgs.map((f){
                    print(f);
                    return Padding(padding: EdgeInsets.fromLTRB(0, 10.0, 0, 0),
                      child: MyBigImg(
                        imgUrl: f, 
                        child: Image.network(f, fit: BoxFit.fill,)
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