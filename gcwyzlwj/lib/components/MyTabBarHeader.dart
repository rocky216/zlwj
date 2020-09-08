import 'package:flutter/material.dart';

class MyTabBarHeader extends StatelessWidget implements PreferredSize{
  final Widget title;
  final List<Tab> tabs;
  final TabController controller;
  final Widget actions;
  const MyTabBarHeader({Key key, this.title, @required this.tabs, @required this.controller, this.actions}) : super(key: key);



  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: this.title,
      leading: Container(
        width: 40.0,
        child: IconButton(
          onPressed: (){
            Navigator.of(context).pop();
          },
          icon: Icon(Icons.close, color: Color(0xFF666666),),
        ),
      ),
      actions: this.actions!=null?[this.actions]:[],
      backgroundColor: Colors.white,
      elevation: 0,
      brightness: Brightness.light,
      bottom: TabBar(
        controller: this.controller,
        //是否可以滚动
        isScrollable: false,
        //选中的颜色
        indicatorColor: Colors.blue,
        //未选中的颜色
        unselectedLabelColor:Colors.black, 
        //文字颜色
        labelColor: Colors.blue,
        tabs: this.tabs,
      ),
    );
  }

  @override
  // TODO: implement child
  Widget get child => null;

  @override
  // TODO: implement preferredSize
  Size get preferredSize => new Size.fromHeight(90.0);
}