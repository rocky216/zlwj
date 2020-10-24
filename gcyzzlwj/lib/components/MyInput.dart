import 'package:flutter/material.dart';

/* 
* label 名称
* maxLines最大行
* onChange 回调
* enabled 是否警用 默认true
 */

class MyInput extends StatefulWidget {
  final Widget label; 
  final maxLines; 
  final Function onChange;
  final bool enabled;
  final Widget child;
  final EdgeInsets padding;
  final controller;
  final String hintText;
  MyInput({Key key, this.controller, @required this.label, this.maxLines=1, this.onChange, this.enabled=true, this.child, this.padding, this.hintText=""}) : super(key: key);

  @override
  _MyInputState createState() => _MyInputState();
}

class _MyInputState extends State<MyInput> {

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: widget.padding,
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: Color(0xFFdddddd)))
      ),
       child: Row(
        //  mainAxisAlignment: MainAxisAlignment.start,
         children: <Widget>[
           Expanded(
             flex: 2,
             child: Container(
               padding: EdgeInsets.only(right: 5.0),
               alignment: Alignment.centerRight,
               child: widget.label,
             )
            ),
           Expanded(
             flex: 7,
             child: widget.child==null?TextField(
               controller: widget.controller,
                enabled: widget.enabled,
                style: TextStyle(fontSize: 14),
                maxLines: widget.maxLines,
                decoration: InputDecoration(
                  hintText: widget.hintText,
                  contentPadding: EdgeInsets.all(0),
                  disabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0x0cdddddd))
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0x0cdddddd))
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0x0cdddddd))
                  )
                ),
                onChanged: (v){
                  widget.onChange(v);
                },
              )
              :widget.child
            )
         ],
       ),
    );
  }
}