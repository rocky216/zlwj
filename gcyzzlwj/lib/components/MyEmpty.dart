import 'package:flutter/material.dart';

class MyEmpty extends StatelessWidget {
  const MyEmpty({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: 200,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(IconData(0xe608, fontFamily: 'AntdIcons'), color: Colors.black26, size: 50,),
          Text("暂无消息", style: TextStyle(color: Colors.grey, fontSize: 12.0),)
        ],
      ),
    );
  }
}