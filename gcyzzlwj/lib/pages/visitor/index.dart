import 'package:flutter/material.dart';
import 'package:gcyzzlwj/components/MyHeader.dart';
import 'package:gcyzzlwj/utils/http.dart';
import 'package:qr_flutter/qr_flutter.dart';

class VisitorPage extends StatefulWidget {
  VisitorPage({Key key}) : super(key: key);

  @override
  _VisitorPageState createState() => _VisitorPageState();
}

class _VisitorPageState extends State<VisitorPage> {
  String ownercode;

  @override
  void initState() { 
    super.initState();
    this.initial();
  }

  initial() async {
    var data = await NetHttp.request("/api/app/owner/qr/owner", context, params: {'type':"1"});
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
        title: "业主二维码",
        actions: MaterialButton(
          onPressed: (){
            Navigator.of(context).pushNamed("/tovisitor");
          },
          child: Text("访客二维码", style: TextStyle(color: Colors.blue),),
        ),
      ),
      body: Center(
        child: this.ownercode==null?Container()
        :Container(
          child: Column(
            children: <Widget>[
              SizedBox(height: 30.0,),
              Text("业主开门二维码"),
              QrImage(
                data: this.ownercode,
                version: QrVersions.auto,
                size: 230.0,
              ),
              Text("有效时长4小时", style: TextStyle(color: Color(0xFFf13d18)),)
            ],
          ),
        ),
      ),
    );
  }
}