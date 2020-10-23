import 'package:flutter/material.dart';
import 'package:gcwyzlwj/components/MyHeader.dart';
import 'package:gcwyzlwj/components/MyScrollView.dart';

class MyShowImage extends StatelessWidget {
  final arguments;
  const MyShowImage({Key key, this.arguments}) : super(key: key);

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyHeader(
        title: Text("查看大图"),
      ),
      body: MyScrollView(
        child: Center(
          child: Image.network(arguments["img"], width: double.infinity, fit: BoxFit.fill,),
        ),
      )
    );
  }
}

