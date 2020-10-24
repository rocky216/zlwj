import 'package:flutter/material.dart';

class MyCard extends StatelessWidget {

  final Widget child;
  final title;
  final extra;

  const MyCard({Key key, this.child, this.title, this.extra}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Colors.white),
      padding: EdgeInsets.all(5.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
        Container(
          padding: EdgeInsets.fromLTRB(0, 6.0, 0, 6.0),
          decoration: BoxDecoration(border: Border(bottom: BorderSide(width: 1.0, color: Color(0xFFdddddd)))),
          child: Flex(
            direction: Axis.horizontal,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              this.title==null?Container():this.title,
              this.extra==null?Container():this.extra
            ],
          )
        ),
        Container(
          padding: EdgeInsets.all(8.0),
          child: this.child,
        )
      ],),
    );
  }
}