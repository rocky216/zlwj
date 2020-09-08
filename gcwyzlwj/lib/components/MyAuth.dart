import 'package:flutter/material.dart';
import 'package:gcwyzlwj/utils/index.dart';

class MyAuth extends StatefulWidget {
  final Widget child;
  final String auth;
  MyAuth({Key key, this.auth, @required this.child}) : super(key: key);

  @override
  _MyAuthState createState() => _MyAuthState();
}

class _MyAuthState extends State<MyAuth> {
  List data;
  @override
  void initState() { 
    super.initState();
    this.getUserAuth();
  }

  getUserAuth() async {
    Map userInfo = await getUserInfo();
    if(userInfo != null){
      setState(() {
        this.data = userInfo["userMenu"];
      });
    }
  }

  @override
  Widget build(BuildContext context) {

    return widget.auth==null || (data != null && data.any((o)=>o["key"]==widget.auth)) ? 
    widget.child
    :Container();
  }
}