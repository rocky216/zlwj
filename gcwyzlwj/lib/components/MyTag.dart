import 'package:flutter/material.dart';

class MyTag extends StatelessWidget {
  final text;
  final Color bg;
  final bool ghost;

  const MyTag({Key key, @required this.text, this.bg, this.ghost=false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(2.0),
        border: Border.all(color: ghost?bg==null?Colors.grey:bg:Color(0x0cdddddd)),
        color: !ghost?
          bg == null?Colors.grey:bg
          :Color(0x0cdddddd)
      ),
      child: Text(this.text, style: TextStyle(color: !ghost?Colors.white:bg==null?Colors.black:bg, fontSize: 11),),
    );
  }
}