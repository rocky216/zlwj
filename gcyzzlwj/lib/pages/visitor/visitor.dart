import 'package:flutter/material.dart';
import 'package:gcyzzlwj/components/MyHeader.dart';
import 'package:gcyzzlwj/utils/http.dart';
import 'package:qr_flutter/qr_flutter.dart';

class ToVisitorPage extends StatefulWidget {
  ToVisitorPage({Key key}) : super(key: key);

  @override
  _ToVisitorPageState createState() => _ToVisitorPageState();
}

class _ToVisitorPageState extends State<ToVisitorPage> {
  String ownercode;

  void initState() { 
    super.initState();
    this.initial();
  }

  initial() async {
    var data = await NetHttp.request("/api/app/owner/qr/owner", context, params: {'type':"2"});
    if(data != null){
      setState(() {
        this.ownercode = data;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyHeader(
        title: "访客二维码",
      ),
      body: Center(
        child: this.ownercode == null? Container()
        :Container(
          child: Column(
            children: <Widget>[
              SizedBox(height: 30.0,),
              Text("访客开门二维码"),
              QrImage(
                data: this.ownercode,
                version: QrVersions.auto,
                size: 230.0,
              ),
              Text("有效时长12小时", style: TextStyle(color: Color(0xFFf13d18)),)
            ],
          ),
        ),
      ),
    );
  }
}