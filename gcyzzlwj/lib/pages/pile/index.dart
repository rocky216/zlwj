import 'package:flutter/material.dart';
import 'package:gcyzzlwj/components/MyHeader.dart';

class PilePage extends StatefulWidget {
  PilePage({Key key}) : super(key: key);

  @override
  _PilePageState createState() => _PilePageState();
}

class _PilePageState extends State<PilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyHeader(
        title: "智能充电桩",
      ),
    );
  }
}