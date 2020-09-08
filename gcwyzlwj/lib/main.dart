import 'dart:io';
import 'package:amap_location/amap_location.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:gcwyzlwj/config/base.dart';
import 'package:gcwyzlwj/redux/store.dart';
import 'package:gcwyzlwj/router/index.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:jpush_flutter/jpush_flutter.dart';

void main(){
  if(Platform.isIOS){
    AMapLocationClient.setApiKey(amapKey);
  }
  
  if(Platform.isAndroid){
    SystemUiOverlayStyle systemUiOverlayStyle =
        SystemUiOverlayStyle(statusBarColor: Colors.white);
    SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
  }
  return runApp(MyApp());
}

class MyApp extends StatefulWidget {
  MyApp({Key key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final JPush jpush = new JPush();

  @override
  void initState() { 
    super.initState();
    this.initPlatformState();
  }

  Future<void> initPlatformState() async {
    String platformVersion;

    try {
      jpush.addEventHandler(
          onReceiveNotification: (Map<String, dynamic> message) async {
        print("接收通知: $message");
        
      }, onOpenNotification: (Map<String, dynamic> message) async {
        print("打开通知: $message");
        
      }, onReceiveMessage: (Map<String, dynamic> message) async {
        print("接收消息: $message");
       
      }, onReceiveNotificationAuthorization:
              (Map<String, dynamic> message) async {
        print("授权接收通知: $message");
        
      });
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }

    jpush.setup(
      appKey: "58d210ba92ddb2b79fd84286", //你自己应用的 AppKey
      channel: "theChannel",
      production: false,
      debug: true,
    );
    jpush.applyPushAuthority(
        new NotificationSettingsIOS(sound: true, alert: true, badge: true));

    // Platform messages may fail, so we use a try/catch PlatformException.
    jpush.getRegistrationID().then((rid) {
      print("获取RegistrationID: $rid");
    });

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion(
      value: SystemUiOverlayStyle.dark,
      child: FlutterEasyLoading(
        child: StoreProvider(
          store: createStore(),
          child: MaterialApp(
            localizationsDelegates: [
              //此处
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
            ],
            supportedLocales: [
              //此处
              const Locale('zh', 'CH'),
              const Locale('en', 'US'),
            ],
            locale: Locale("zh"),
            title: '智联万家',
            theme: ThemeData(
              primaryColor: Colors.blue,
            ),
            initialRoute: "/launch",
            onGenerateRoute: onGenerateRoute,
          )
        ),
      ),
    );
  }
}

// class MyApp extends StatelessWidget {
//   // This widget is the root of your application.
  

//   @override
//   Widget build(BuildContext context) {

//     return AnnotatedRegion(
//       value: SystemUiOverlayStyle.dark,
//       child: FlutterEasyLoading(
//         child: StoreProvider(
//           store: createStore(),
//           child: MaterialApp(
//             localizationsDelegates: [
//               //此处
//               GlobalMaterialLocalizations.delegate,
//               GlobalWidgetsLocalizations.delegate,
//             ],
//             supportedLocales: [
//               //此处
//               const Locale('zh', 'CH'),
//               const Locale('en', 'US'),
//             ],
//             locale: Locale("zh"),
//             title: '智联万家',
//             theme: ThemeData(
//               primaryColor: Colors.blue,
//             ),
//             initialRoute: "/launch",
//             onGenerateRoute: onGenerateRoute,
//           )
//         ),
//       ),
//     );
//   }
// }
