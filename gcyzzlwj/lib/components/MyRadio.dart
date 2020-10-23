import 'package:flutter/material.dart';

class MyRadio extends StatefulWidget {
  final Widget title;
  final int value;
  final groupValue;
  final Function onChanged;
  final bool disabled;

  MyRadio({Key key, this.title, @required this.value, @required this.groupValue, @required this.onChanged, 
  this.disabled=false}) : super(key: key);

  @override
  _MyRadioState createState() => _MyRadioState();
}

class _MyRadioState extends State<MyRadio> {
  @override
  Widget build(BuildContext context) {
    return Container(
       child: Row(
         children: [
           Radio(value: widget.value, groupValue: widget.groupValue, onChanged: (v){
             widget.onChanged(v);
           }),
           GestureDetector(
             child: widget.title,
             onTap: (){
               widget.onChanged(widget.value);
             },
           )
         ],
       ),
    );
  }
}