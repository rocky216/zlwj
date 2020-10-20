import 'package:flutter/material.dart';
import 'package:gcyzzlwj/components/MyHeader.dart';

class PayPlatePage extends StatefulWidget {
  PayPlatePage({Key key}) : super(key: key);

  @override
  _PayPlatePageState createState() => _PayPlatePageState();
}

class _PayPlatePageState extends State<PayPlatePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyHeader(
        title: "停车支付",
      ),
    );
  }
}