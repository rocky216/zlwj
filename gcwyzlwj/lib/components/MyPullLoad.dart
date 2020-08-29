import 'package:flutter/material.dart';
import './MyEmpty.dart';


class MyPullLoad extends StatelessWidget {
  final List dataList;
  final bool bBtn;

  const MyPullLoad({Key key, this.dataList, this.bBtn}) : super(key: key);

  

  @override
  Widget build(BuildContext context) {
    return this.bBtn==true?this.dataList.isEmpty?
      Container(
        alignment: Alignment.center,
        width: double.infinity,
        child: MyEmpty()
        )
      :Container(
        padding: EdgeInsets.all(16.0),
        alignment: Alignment.center,
        child: SizedBox(
          width: 24.0,
          height: 24.0,
          child: CircularProgressIndicator(strokeWidth: 2.0,),
        ),
      ):this.dataList.length>=10? Container(
        padding: EdgeInsets.all(8.0),
        child: Text("已经到底了~",textAlign: TextAlign.center, style: TextStyle(color: Color(0xFF999999)),),
      ):Text("");
  }
}