import 'package:flutter/material.dart';


class MyTabs extends StatelessWidget {
  final List tabs;
  final int current;
  final Function onChange;
  const MyTabs({Key key, @required this.tabs, @required this.current, this.onChange}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: tabs.asMap().keys.map((index){
          bool status = current==index;
          return Expanded(
            child: GestureDetector(
              onTap: (){
                this.onChange(index, tabs[index]);
              },
              child: Container(
                decoration: BoxDecoration(
                  border: Border(right: BorderSide(color: Colors.white))
                ),
                child: Container(
                  color: status?Colors.blue:Color(0xFFeeeeee),
                  padding: EdgeInsets.only(top: 6, bottom: 6),
                  child: Text(tabs[index]["name"], textAlign: TextAlign.center, style: TextStyle(color: status?Colors.white:Colors.black),),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}

// class MyTabs extends StatefulWidget {
//   final List tabs;
//   final int current;
//   final Function onChange;
//   MyTabs({Key key, @required this.tabs, @required this.current, this.onChange}) : super(key: key);

//   @override
//   _MyTabsState createState() => _MyTabsState();
// }

// class _MyTabsState extends State<MyTabs> {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       child: Row(
//         children: widget.tabs.asMap().keys.map((index){
//           bool status = widget.current==index;
//           return Expanded(
//             child: GestureDetector(
//               onTap: (){
//                 print(1212);
//                 widget.onChange(index, widget.tabs[index]);
//               },
//               child: Container(
//                 decoration: BoxDecoration(
//                   border: Border(right: BorderSide(color: Colors.white))
//                 ),
//                 child: Container(
//                   color: status?Colors.blue:Color(0xFFeeeeee),
//                   padding: EdgeInsets.only(top: 6, bottom: 6),
//                   child: Text(widget.tabs[index]["name"], textAlign: TextAlign.center, style: TextStyle(color: status?Colors.white:Colors.black),),
//                 ),
//               ),
//             ),
//           );
//         }).toList(),
//       ),
//     );
//   }
// }

