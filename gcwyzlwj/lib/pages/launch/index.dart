import 'package:flutter/material.dart';

class LaunchPage extends StatefulWidget {
  LaunchPage({Key key}) : super(key: key);

  @override
  _LaunchPageState createState() => _LaunchPageState();
}

class _LaunchPageState extends State<LaunchPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("启动页"),
      ),
    );
  }
}