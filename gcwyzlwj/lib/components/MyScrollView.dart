

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';




// class MyScrollView extends StatefulWidget {
//   final Widget child;
//   MyScrollView({Key key, this.child}) : super(key: key);

//   @override
//   _MyScrollViewState createState() => _MyScrollViewState();
// }

// class _MyScrollViewState extends State<MyScrollView> {


//   @override
//   Widget build(BuildContext context) {
//     return Theme.of(context).platform == TargetPlatform.iOS
//       ? CupertinoScrollbar(
//         child: SingleChildScrollView(
//           child: Column(children: <Widget>[
//             widget.child
//           ],),
//         )
//       ): Stack(
//         children: <Widget>[
//           Scrollbar(
//             child: SingleChildScrollView(
//               child: Column(
//                 children: <Widget>[
//                   widget.child,
                  
//                 ],
//               )
//             )
//           ),
//           Align(
//             alignment: Alignment.center,
//             child: Container(
//               decoration: BoxDecoration(color: Color(0x00000000)),
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: <Widget>[
//                 Loading(indicator: BallPulseIndicator(), size: 60.0,color: Theme.of(context).primaryColor),
//                 Text("正在加载...")
//               ],),
//             ),
//           ),
          
//         ],
//       );
//   }
// }



class MyScrollView extends StatelessWidget {
  final Widget child;
  MyScrollView({Key key, this.child}) : super(key: key);
  


  @override
  Widget build(BuildContext context) {
    return Scrollbar(
          child: SingleChildScrollView(
            child: this.child,
          )
        );
  }
}