import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:gcyzzlwj/pages/launch/index.dart';
import 'package:gcyzzlwj/redux/store.dart';
import 'package:gcyzzlwj/routers/index.dart';


void main() {
  runApp(MyApp());
  SystemUiOverlayStyle _style =
          SystemUiOverlayStyle(
            statusBarColor: Colors.transparent
          );
      SystemChrome.setSystemUIOverlayStyle(_style);
}

class MyApp extends StatelessWidget { 
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '智联万家',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: LaunchPage(),
      builder: (BuildContext context, Widget child){
        return StoreProvider(
          store: createStore(),
          child: FlutterEasyLoading(child: child,),
        );
      },
      onGenerateRoute: onGenerateRoute
    );
  }
}

// class MyApp extends StatelessWidget { 
//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//         title: '智联万家',
//         theme: ThemeData(
//           primarySwatch: Colors.blue,
//           visualDensity: VisualDensity.adaptivePlatformDensity,
//         ),
//         home: LaunchPage(),
//         // builder: (BuildContext context, Widget child){
//         //   return FlutterEasyLoading(child: child,);
//         // },
//         onGenerateRoute: onGenerateRoute,
//       );
//   }
// }

