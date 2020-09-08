
import 'package:flutter/material.dart';
import 'package:gcwyzlwj/utils/index.dart';
import 'package:jpush_flutter/jpush_flutter.dart';


class LaunchPage extends StatefulWidget {
  LaunchPage({Key key}) : super(key: key);

  @override
  _LaunchPageState createState() => _LaunchPageState();
}

class _LaunchPageState extends State<LaunchPage> {
  
@override
  void initState() {
    // TODO: implement initState
    super.initState();
    this.isLogin();
  }

  

  isLogin() async {
    var userInfo = await getUserInfo();
    if(userInfo == null){
      Navigator.of(context).pushNamedAndRemoveUntil("/login", (route)=>false);
    }else{
      Navigator.of(context).pushNamedAndRemoveUntil("/index", (route)=>false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: new Center(
        child: Text("正在加载数据。。。")
      ),
    );
  }


  // void _checkPersmission() async {
  //   bool hasPermission = 
  //     await SimplePermissions.checkPermission(Permission.WhenInUseLocation);
  // }
}