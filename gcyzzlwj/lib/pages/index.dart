import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gcyzzlwj/components/MyScan.dart';
import 'package:gcyzzlwj/pages/home/index.dart';
import 'package:gcyzzlwj/pages/users/index.dart';
import 'package:gcyzzlwj/utils/index.dart';

class IndexPage extends StatefulWidget {
  IndexPage({Key key}) : super(key: key);

  @override
  _IndexPageState createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> {
  DateTime lastPopTime;
  int _currentIndex=0;
  List pTab = [ HomePage(), UsersPage()];

  @override
  void initState() { 
    super.initState();
    this.getRid();
  }

  getRid(){
    initPlatformState(context);
  }


  activeColor(int key){
    return this._currentIndex==key?Theme.of(context).primaryColor:Colors.grey;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Scaffold(
      body: pTab[_currentIndex],
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Container(
        width: 45.0,
        height: 45.0,
        child: MyScan(
          next: (result) async {
            scanJump(context, result);
          },
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.all(Radius.circular(23.0)),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey,
                  blurRadius: 3.0
                )
              ]),
            child: Icon(Icons.crop_free, color: Colors.grey),
          )
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        shape: CircularNotchedRectangle(),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Container(
              height: 45.0,
              child: FlatButton(
                child: Column(
                  children: <Widget>[
                    Icon(Icons.home, color: this.activeColor(0),),
                    Text("首页", style: TextStyle(fontSize: 12.0, color: this.activeColor(0)))
                  ],
                ),
                onPressed: (){
                  setState(() {
                    this._currentIndex = 0;
                  });
                },
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 20.0),
              child: Text("扫一扫", style: TextStyle(color: Colors.grey, fontSize: 12.0),),
            ),
            Container(
              height: 45.0,
              child: FlatButton(
                child: Column(
                  children: <Widget>[
                    Icon(Icons.person, color: this.activeColor(1)),
                    Text("我的", style: TextStyle(fontSize: 12.0, color: this.activeColor(1)))
                  ],
                ),
                onPressed: (){
                  setState(() {
                    this._currentIndex = 1;
                  });
                },
              ),
            ),
          ],
        ),
      ),
    ), 
    
    onWillPop: () async {
      print(lastPopTime);
      print(11111);
      if(lastPopTime == null || DateTime.now().difference(lastPopTime) > Duration(seconds: 2)){
          lastPopTime = DateTime.now();
          showToast("再按一次退出");
        }else{
          lastPopTime = DateTime.now();
          // 退出app
          await SystemChannels.platform.invokeMethod('SystemNavigator.pop');
        }
      },
    );
  }
}