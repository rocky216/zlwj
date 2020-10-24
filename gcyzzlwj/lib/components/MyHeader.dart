
import 'package:flutter/material.dart';

class MyHeader extends StatefulWidget implements PreferredSizeWidget {
  final String theme;
  final String title;
  final Widget actions;
  final Widget leading;
  final List<Tab> tabs;
  final controller;

  MyHeader({Key key, this.theme, this.title, this.actions, this.leading, this.tabs, this.controller}) : super(key: key);

  @override
  _MyHeaderState createState() => _MyHeaderState();

  @override
  // TODO: implement preferredSize
  Size get preferredSize => new Size.fromHeight( this.tabs ==null || this.controller==null?45.0:80);
}

class _MyHeaderState extends State<MyHeader> {
  @override
  Widget build(BuildContext context) {
    


    return new SafeArea(
      top: false,
      child: Container(
        decoration: BoxDecoration(
          color: widget.theme=="blue" ? Colors.blue:Color(0xFFfafafa),
        ),
        
        child: AppBar(
          title: Text(widget.title??"", style: TextStyle( color: widget.theme=="blue"?Colors.white: Colors.black , fontSize: 16.0),),
          backgroundColor:  widget.theme=="blue"?Colors.blue : Color(0xFFfafafa),
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
          bottom: widget.tabs==null || widget.controller==null ? null 
            :TabBar(
            controller: widget.controller,
            //是否可以滚动
            isScrollable: false,
            //选中的颜色
            indicatorColor: Colors.blue,
            //未选中的颜色
            unselectedLabelColor:Colors.black, 
            //文字颜色
            labelColor: Colors.blue,
            // indicatorSize: TabBarIndicatorSize.label, 
            tabs: widget.tabs,
          ),
        ),
      ),
    );
  }
}