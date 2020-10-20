import 'package:flutter/material.dart';
import './MyEmpty.dart';


class MyPullLoad extends StatelessWidget {
  final Map data;

  const MyPullLoad({Key key, this.data}) : super(key: key);

  Widget backItem(){
    List list = this.data["list"];
    if(list.isEmpty){
      return MyEmpty();
    }
    if(list.length>=15 && list.length >= this.data["total"]){
      return Container(
        padding: EdgeInsets.all(8.0),
        child: Text("已经到底了~",textAlign: TextAlign.center, style: TextStyle(color: Color(0xFF999999)),),
      );
    }
    if( list.length < this.data["total"]){
      return Container(
        padding: EdgeInsets.all(16.0),
        alignment: Alignment.center,
        child: SizedBox(
          width: 24.0,
          height: 24.0,
          child: CircularProgressIndicator(strokeWidth: 2.0,),
        ),
      );
    }
    return Container();
  }

  @override
  Widget build(BuildContext context) {
    return this.backItem();
  }

  // @override
  // Widget build(BuildContext context) {
  //   return dataList.isEmpty?MyEmpty()
  //         :bBtn?Container(
  //           padding: EdgeInsets.all(8.0),
  //           child: dataList.length>10? Text("已经到底了~",textAlign: TextAlign.center, style: TextStyle(color: Color(0xFF999999)),)
  //             :Container(),
  //         )
  //         :Container(
  //           padding: EdgeInsets.all(16.0),
  //           alignment: Alignment.center,
  //           child: SizedBox(
  //             width: 24.0,
  //             height: 24.0,
  //             child: CircularProgressIndicator(strokeWidth: 2.0,),
  //           ),
  //         );
  // }
}