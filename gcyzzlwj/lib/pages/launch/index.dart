import 'package:flutter/material.dart';
import 'package:gcyzzlwj/utils/index.dart';

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
      Navigator.of(context).pushNamedAndRemoveUntil("/login", (route) => false);
    }else{
      Navigator.of(context).pushNamedAndRemoveUntil("/index", (route) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: new Center(
        child: Container(
          width: double.infinity,
          height: MediaQuery.of(context).size.height,
          child: Image.asset("assets/images/launch_image.png", fit: BoxFit.cover,),
        )
      ),
    );
  }
}