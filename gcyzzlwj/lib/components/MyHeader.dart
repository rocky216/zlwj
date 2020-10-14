
import 'package:flutter/material.dart';

class MyHeader extends StatefulWidget implements PreferredSizeWidget {
  final String theme;
  final String title;
  final Widget actions;
  final Widget leading;

  MyHeader({Key key, this.theme, this.title, this.actions, this.leading}) : super(key: key);

  @override
  _MyHeaderState createState() => _MyHeaderState();

  @override
  // TODO: implement preferredSize
  Size get preferredSize => new Size.fromHeight(45.0);
}

class _MyHeaderState extends State<MyHeader> {
  @override
  Widget build(BuildContext context) {
    
    return new SafeArea(
      top: false,
      child: Container(
        decoration: BoxDecoration(
          color: widget.theme=="blue" ? Colors.blue:Colors.white,
        ),
        
        child: AppBar(
          title: Text(widget.title??"", style: TextStyle( color: widget.theme=="blue"?Colors.white: Colors.black , fontSize: 16.0),),
          backgroundColor:  widget.theme=="blue"?Colors.blue : Colors.white,
          brightness: widget.theme=="blue"? Brightness.dark : Brightness.light,
          elevation: 0,
          titleSpacing: 0.0,
          leading: widget.leading==null?
            Navigator.canPop(context)? 
            Container(
              width: 20.0,
              child: FlatButton(child: Icon(Icons.close), onPressed: (){
                Navigator.of(context).pop();
              }),
            ):null
            :widget.leading,
          actions: widget.actions==null? [] : [widget.actions],
        ),
      ),
    );
  }
}