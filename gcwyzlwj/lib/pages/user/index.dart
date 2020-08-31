import 'package:flutter/material.dart';
import 'package:gcwyzlwj/components/MyHeader.dart';
import 'package:gcwyzlwj/components/MyScrollView.dart';

class UserPage extends StatefulWidget {
  UserPage({Key key}) : super(key: key);

  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyHeader(
        title: Text("个人中心"),
      ),
      body: MyScrollView(
        child: Form(
          child: Column(
            children: <Widget>[
              TextFormField(
                decoration: InputDecoration(labelText: "用户名", hintText: "请输入用户名", prefixIcon: Icon(Icons.person)),
              )
            ],
          ),
        ),
      ),
    );
  }
}