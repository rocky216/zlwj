import 'package:flutter/material.dart';

class MyEmpty extends StatelessWidget {
  const MyEmpty({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: 100,
      child: Icon(IconData(0xe696, fontFamily: 'AntdIcons'), color: Colors.grey, size: 40,),
    );
  }
}