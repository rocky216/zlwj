import 'package:flutter/material.dart';

class MyBetweeItem extends StatelessWidget {
  final String title;
  final String middle;
  final String value;
  const MyBetweeItem({Key key, this.title, this.value, this.middle}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(0, 3.0, 0, 3.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(this.title, style: TextStyle(color: Color(0xFF666666)),),
          this.middle != null ?Text(this.middle):Container(),
          Text(this.value)
        ],
      ),
    );
  }
}