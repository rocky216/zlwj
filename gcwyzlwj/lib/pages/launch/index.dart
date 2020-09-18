import 'dart:isolate';
import 'dart:ui';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gcwyzlwj/components/MyAgreement.dart';
import 'package:gcwyzlwj/config/base.dart';
import 'package:gcwyzlwj/pages/auth/login.dart';
import 'package:gcwyzlwj/pages/index.dart';
import 'package:gcwyzlwj/utils/http.dart';
import 'package:gcwyzlwj/utils/index.dart';
import 'package:url_launcher/url_launcher.dart';


class LaunchPage extends StatefulWidget {
  LaunchPage({Key key}) : super(key: key);

  @override
  _LaunchPageState createState() => _LaunchPageState();
}

class _LaunchPageState extends State<LaunchPage> {
  List updateapp;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    
    this.appVersion();
    
  }

  appVersion() async {
    var data = await NetHttp.request("/api/app/property/common/app/version", context, params: {});
    if(data != null){
      if(data["versionNo"] != version){
        popconfirm(
          context, 
          title:Text("发现新版本，请及时更新？"),
          confirm: FlatButton(
            onPressed: () async {
              if(Platform.isAndroid){
                if (await canLaunch( data["appResourceUrl"] )) {
                  await launch(data["appResourceUrl"]);
                }
              }else if(Platform.isIOS){
                if (await canLaunch( appStore )) {
                  await launch(appStore);
                }
              }
              
            }, 
            child: Text("更新")),
          cancel: Container()
        );
      }else{
        this.isLogin();
      }
    }
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
  

  isLogin() async {
    var userInfo = await getUserInfo();
    if(userInfo == null){
      Navigator.pushAndRemoveUntil(
        context,
        new MaterialPageRoute(builder: (context) => new LoginPage()),
        (route) => route == null,
      );
      // Navigator.of(context).pushNamedAndRemoveUntil("/login", (route)=>false);
    }else{
      this.tipsAgreement();
      Navigator.pushAndRemoveUntil(
        context,
        new MaterialPageRoute(builder: (context) => new IndexPage()),
        (route) => route == null,
      );
      // Navigator.of(context).pushNamedAndRemoveUntil("/index", (route)=>false);
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