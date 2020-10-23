import 'package:flutter/material.dart';
import 'package:gcyzzlwj/components/MyBetweeItem.dart';
import 'package:gcyzzlwj/components/MyBigImg.dart';
import 'package:gcyzzlwj/components/MyHeader.dart';
import 'package:gcyzzlwj/components/MyInput.dart';
import 'package:gcyzzlwj/components/MyScrollView.dart';
import 'package:gcyzzlwj/components/MyTag.dart';
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

  handlenStatus(str){
    Color color = Colors.red;
    String text = "";
    if(str.toString()=="0"){
      color=Colors.red;
      text="待处理";
    }else if(str.toString()=="1"){
      color=Colors.orange;
      text="待处中";
    }else {
      color=Theme.of(context).primaryColor;
      text="已处理";
    }
    return MyTag(text: text, bg: color, ghost: true,);
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
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    this.handlenStatus(detail["processingState"]),
                    Padding(
                      padding: EdgeInsets.only(left: 10.0, right: 10.0),
                      child: MyTag(text: detail["repairTypeName"], ghost: true,),
                    ),
                    Text(detail["buildTime"], style: TextStyle(color: Color(0xFF666666)),)
                  ],
                ),
              ),

              detail["processingState"]=="1"?
              Container(
                margin: EdgeInsets.only(bottom: 20.0),
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('分配信息：'),
                        Text(detail["endUserName"]),
                        Text(detail["processingTime"]),
                      ],
                    ),
                  ],
                ),
              ):Container(),

              Container(
                width: double.infinity,
                child: Text(detail["repairInfo"]),
              ),
              
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(10.0),
                child: Wrap(
                  children: (this.detail["imgSubUrls"] as List).map((f){
                    return Container(
                      margin: EdgeInsets.only(right: 5.0, bottom: 5.0),
                      child: MyBigImg(
                        imgUrl: f, 
                        child: Image.network(f, fit: BoxFit.cover, width: 80.0, height: 90.0,)
                      ),
                    );
                  }).toList(),
                ),
              ),

              

              detail["processingState"]=="2"?
              Container(
                margin: EdgeInsets.only(top: 20.0),
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text('处理信息：'),
                        Text(detail["endUserName"]),
                        Text(detail["endTime"]),
                      ],
                    ),
                    Text(detail["endInfo"]),
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(10.0),
                      child: Wrap(
                        children: (this.detail["imgEndUrls"] as List).map((f){
                          return Container(
                            margin: EdgeInsets.only(right: 5.0, bottom: 5.0),
                            child: MyBigImg(
                              imgUrl: f, 
                              child: Image.network(f, fit: BoxFit.cover,  width: 80.0, height: 90.0,)
                            ),
                          );
                        }).toList(),
                      ),
                    )
                  ],
                ),
              ):Container(),
              
            ],
          ),
        ),
      ),
    );
  }
}