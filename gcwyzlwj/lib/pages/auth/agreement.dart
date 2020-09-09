import 'package:flutter/material.dart';
import 'package:gcwyzlwj/components/MyAgreement.dart';
import 'package:gcwyzlwj/components/MyHeader.dart';
import 'package:gcwyzlwj/components/MyScrollView.dart';

class UserAgreement extends StatelessWidget {
  const UserAgreement({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyHeader(
        title: Text("用户隐私及协议"),
      ),
      body: MyScrollView(
        child: Container(
          padding: EdgeInsets.fromLTRB(10.0, 0, 10.0, 10.0),
          child: MyAgreement(),
        ),
      ),
    );
  }
}