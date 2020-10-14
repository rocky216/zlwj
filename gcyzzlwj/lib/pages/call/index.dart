import 'package:flutter/material.dart';
import 'package:gcyzzlwj/components/MyHeader.dart';
import 'package:gcyzzlwj/components/MyList.dart';
import 'package:url_launcher/url_launcher.dart';

class CallPage extends StatefulWidget {
  CallPage({Key key}) : super(key: key);

  @override
  _CallPageState createState() => _CallPageState();
}

class _CallPageState extends State<CallPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyHeader(title: "呼叫物业",),
      body: MyList(
        url: "/api/app/he/link/", 
        itemBuilder: (dataList, i){
          return ListTile(
            leading: CircleAvatar(
              backgroundColor: Color(0xFFeeeeee),
              backgroundImage: dataList[i]["headUrl"].isNotEmpty?NetworkImage(dataList[i]["headUrl"]):null,
              child: dataList[i]["headUrl"].isNotEmpty?Container() : Icon(Icons.person, color: Colors.grey,),
            ),
            title: Text(dataList[i]["name"]),
            onTap: () async {
              var url = "tel:${dataList[i]['info']}";
              print(url);
              if (await canLaunch(url)) {
                await launch(url);
              } else {
                throw 'Could not launch $url';
              }
            },
          );
        }
      ),
    );
  }
}