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

void main() async {
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
  

  @override
  void initState() { 
    super.initState();
    
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
