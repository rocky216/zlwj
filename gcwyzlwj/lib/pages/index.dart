import 'package:flutter/material.dart';

class IndexPage extends StatefulWidget {
  IndexPage({Key key}) : super(key: key);

  @override
  _IndexPageState createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("金庐名居"),
      ),
      body: Container(
        child: FlatButton(onPressed: (){
          Navigator.of(context).pushNamed("/launch");
        }, child: Text("跳转")),
      ),
    );
  }
}