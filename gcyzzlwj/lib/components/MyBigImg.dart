import 'package:flutter/material.dart';

class MyBigImg extends StatelessWidget {
  final Widget child;
  final String imgUrl;
  MyBigImg({Key key,@required this.imgUrl, @required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: (){
          Navigator.of(context).pushNamed("/showimg", arguments: {
            "img": this.imgUrl
          });
        },
        child: this.child,
      );
  }
}