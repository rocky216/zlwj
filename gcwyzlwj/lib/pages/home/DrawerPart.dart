import 'package:flutter/material.dart';
import 'package:gcwyzlwj/utils/http.dart';
import 'package:gcwyzlwj/utils/index.dart';

class DrawerPart extends StatefulWidget {
  final Function next;
  DrawerPart({Key key, @required this.next}) : super(key: key);

  @override
  _DrawerPartState createState() => _DrawerPartState();
}

class _DrawerPartState extends State<DrawerPart> {
  List heList = [];

  @override
  void initState() { 
    super.initState();
    this.getHeList();
  }

  getHeList() async {
    Map<String, dynamic> map = await getUserInfo();
    if(map != null){
      setState(() {
        heList = map["allHe"];
      });
    }
  }

  onChangeHe(Map<String,dynamic> item) async {
    var data = await NetHttp.request("/api/app/property/cutHe", context, method: "post", params: {
      "nowHeId": item["id"]
    });
    if(data != null){
      var userInfo = await getUserInfo();
      userInfo["nowHe"] = item;
      await setUserInfo(userInfo);
      Navigator.of(context).pop();
      widget.next();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        margin: EdgeInsets.only(top: 50.0),
        child: ListView(
          padding: EdgeInsets.zero,
          children: heList.map((f)=>ListTile(
            title: Text(f["name"]),
            leading: CircleAvatar(child: Icon(Icons.home, size: 20.0,), radius: 15.0,),
            onTap: (){
              this.onChangeHe(f);
            },
          )).toList()
          
        ),
      ),
    );
  }
}