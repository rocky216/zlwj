
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gcwyzlwj/components/MyAgreement.dart';
import 'package:gcwyzlwj/config/base.dart';
import 'package:gcwyzlwj/utils/http.dart';
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
    // this.appVersion();
  }

  appVersion() async {
    var data = await NetHttp.request("/api/app/property/common/app/version", context, params: {});
    if(data != null){
      print(data);
      if(data["versionNo"] != version){

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
      });
    }
  }
  

  isLogin() async {
    var userInfo = await getUserInfo();
    if(userInfo == null){
      Navigator.of(context).pushNamedAndRemoveUntil("/login", (route)=>false);
    }else{
      this.tipsAgreement();
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