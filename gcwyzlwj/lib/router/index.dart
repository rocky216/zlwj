import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gcwyzlwj/pages/auth/login.dart';
import 'package:gcwyzlwj/pages/clock/index.dart';
import 'package:gcwyzlwj/pages/crmt/examerr/index.dart';
import 'package:gcwyzlwj/pages/crmt/expend/index.dart';
import 'package:gcwyzlwj/pages/crmt/fee/index.dart';
import 'package:gcwyzlwj/pages/crmt/income/index.dart';
import 'package:gcwyzlwj/pages/index.dart';
import 'package:gcwyzlwj/pages/launch/index.dart';


var routes = {
  "/index": (context)=> IndexPage(),
  "/launch": (context)=> LaunchPage(),
  "/clock": (context)=> ClockPage(),
  "/login": (context)=> LoginPage(),
  "/crmt/fee": (context, arguments)=> CrmtList(arguments: arguments),
  "/crmt/expend": (context, arguments)=> CrmtExpend(arguments: arguments),
  "/crmt/income": (context, arguments)=> CrmtIncome(arguments: arguments),
  "/crmt/examerr": (context, arguments)=> CrmtExamerr(arguments: arguments),
};


var onGenerateRoute =  (RouteSettings settings){
  final String name = settings.name;
  final Function pageContentBuilder = routes[name];

  if(pageContentBuilder != null){
    if(settings.arguments != null){
      final Route route = CupertinoPageRoute(
                  builder: (context)=> pageContentBuilder(context, settings.arguments) );
      return route;
    }else{
      final Route route = CupertinoPageRoute(
                  builder: (context)=> pageContentBuilder(context) );
      return route;
    }
  }

};