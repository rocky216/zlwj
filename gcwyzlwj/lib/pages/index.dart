import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gcwyzlwj/pages/home/index.dart';
import 'package:gcwyzlwj/pages/user/index.dart';

class IndexPage extends StatefulWidget {
  IndexPage({Key key}) : super(key: key);

  @override
  _IndexPageState createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> {
  int _currentIndex = 0;

  List<Widget> tabs = [HomePage(), UserPage()];
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: tabs[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(items: [
        BottomNavigationBarItem(icon: Icon(IconData(0xe64a, fontFamily: "AntdIcons"), size: 20.0,), title: Text("工作台")),
        BottomNavigationBarItem(icon: Icon(Icons.person), title: Text("我的")),
      ], currentIndex: _currentIndex, onTap: (index){
        setState(() {
          _currentIndex = index;
        });
      },),
    );
  }
}