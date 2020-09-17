import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gcwyzlwj/components/MyAgreement.dart';
import 'package:gcwyzlwj/pages/home/index.dart';
import 'package:gcwyzlwj/pages/maillist/index.dart';
import 'package:gcwyzlwj/pages/news/index.dart';
import 'package:gcwyzlwj/pages/user/index.dart';
import 'package:gcwyzlwj/utils/index.dart';

class IndexPage extends StatefulWidget {
  IndexPage({Key key}) : super(key: key);

  @override
  _IndexPageState createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> {
  int _currentIndex = 0;

  List<Widget> tabs = [NewsPage(), HomePage(), MailList(), UserPage()];
  
  @override
  void initState() { 
    super.initState();
    this.tipsAgreement();
    this.getRid();
  }
  getRid(){
    initPlatformState(context);
  }

  tipsAgreement() async {
      var agree = await getAgreement();
      if(agree==null){
        popconfirm(context, title: Text("用户协议"), content: Container(
          child: MyAgreement(),
        ), onCancel: () async {
          await SystemChannels.platform.invokeMethod('SystemNavigator.pop');
        }, next: () async {
          await setAgreement();
          Navigator.of(context).pushNamedAndRemoveUntil("/index", (route)=>false);
        });
      }
    }
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: tabs[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        showUnselectedLabels: true,
        unselectedItemColor: Color(0xFF666666),
        unselectedLabelStyle: TextStyle(color:Color(0xFF666666) ),
        selectedItemColor: Colors.blue,
        selectedFontSize: 12.0,
        type: BottomNavigationBarType.fixed,
        items: [
        BottomNavigationBarItem(icon: Icon(IconData(0xe62a, fontFamily: "AntdIcons"), size: 20.0,), title: Text("消息")),
        BottomNavigationBarItem(icon: Icon(IconData(0xe64a, fontFamily: "AntdIcons"), size: 20.0,), title: Text("工作台")),
        BottomNavigationBarItem(icon: Icon(Icons.assignment_ind), title: Text("通讯录")),
        BottomNavigationBarItem(icon: Icon(Icons.person), title: Text("我的")),
      ], currentIndex: _currentIndex, onTap: (index){
        setState(() {
          _currentIndex = index;
        });
      },),
    );
  }
}