import 'package:flutter/material.dart';
import 'package:gcyzzlwj/components/MyHeader.dart';
import 'package:gcyzzlwj/components/MyInput.dart';
import 'package:gcyzzlwj/components/MyScrollView.dart';

class EditUsersPage extends StatefulWidget {
  EditUsersPage({Key key}) : super(key: key);

  @override
  _EditUsersPageState createState() => _EditUsersPageState();
}

class _EditUsersPageState extends State<EditUsersPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyHeader(
        title: "个人信息",
      ),
      body: MyScrollView(
        child: Container(
          child: Column(
            children: [
              MyInput(label: Text("data"))
            ],
          ),
        ),
      ),
    );
  }
}