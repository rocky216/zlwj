import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gcyzzlwj/config/index.dart';
import 'package:gcyzzlwj/utils/http.dart';
import 'package:gcyzzlwj/utils/index.dart';
import 'package:url_launcher/url_launcher.dart';

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
    this.appVersion();
  }

  isLogin() async {
    var userInfo = await getUserInfo();
    if(userInfo == null){
      Navigator.of(context).pushNamedAndRemoveUntil("/login", (route) => false);
    }else{
      Navigator.of(context).pushNamedAndRemoveUntil("/index", (route) => false);
    }
  }

  appVersion() async {
    var data = await NetHttp.request("/api/app/owner/common/app/version", context, params: {});
    if(data != null){
      if( Platform.isAndroid && data["versionNo"] != version){
        confirmDialog(
          context, 
          title:Text("发现新版本，请及时更新？"),
          ok: () async {
            if(Platform.isAndroid){
              if (await canLaunch( data["appResourceUrl"] )) {
                await launch(data["appResourceUrl"]);
              }
            }else if(Platform.isIOS){
              if (await canLaunch( appStore )) {
                await launch(appStore);
              }
            }
          }
        );
      }else{
        this.isLogin();
      }
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