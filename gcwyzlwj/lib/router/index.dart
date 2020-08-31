import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gcwyzlwj/pages/auth/login.dart';
import 'package:gcwyzlwj/pages/crmt/examerr/detail.dart';
import 'package:gcwyzlwj/pages/crmt/examerr/index.dart';
import 'package:gcwyzlwj/pages/crmt/examexpend/detail.dart';
import 'package:gcwyzlwj/pages/crmt/examexpend/index.dart';
import 'package:gcwyzlwj/pages/crmt/examincome/detail.dart';
import 'package:gcwyzlwj/pages/crmt/examincome/index.dart';
import 'package:gcwyzlwj/pages/crmt/expend/detail.dart';
import 'package:gcwyzlwj/pages/crmt/expend/index.dart';
import 'package:gcwyzlwj/pages/crmt/fee/detail.dart';
import 'package:gcwyzlwj/pages/crmt/fee/index.dart';
import 'package:gcwyzlwj/pages/crmt/income/detail.dart';
import 'package:gcwyzlwj/pages/crmt/income/index.dart';
import 'package:gcwyzlwj/pages/daily/clock/index.dart';
import 'package:gcwyzlwj/pages/daily/clock/record.dart';
import 'package:gcwyzlwj/pages/daily/setclock/index.dart';
import 'package:gcwyzlwj/pages/index.dart';
import 'package:gcwyzlwj/pages/launch/index.dart';


var routes = {
  "/index": (context)=> IndexPage(),
  "/launch": (context)=> LaunchPage(),
  "/login": (context)=> LoginPage(),
  "/crmt/fee": (context, arguments)=> CrmtList(arguments: arguments),
  "/crmt/fee/detail": (context, arguments)=> CrmtFeeDetail(arguments: arguments),
  "/crmt/expend": (context, arguments)=> CrmtExpend(arguments: arguments),
  "/crmt/expend/detail": (context, arguments)=> CrmtExpendDetail(arguments: arguments),
  "/crmt/income": (context, arguments)=> CrmtIncome(arguments: arguments),
  "/crmt/income/detail": (context, arguments)=> CrmtIncomeDetail(arguments: arguments),
  "/crmt/examerr": (context, arguments)=> CrmtExamerr(arguments: arguments),
  "/crmt/examerr/detail": (context, arguments)=> CrmtExamerrDetail(arguments: arguments),
  "/crmt/examexpend": (context, arguments)=> CrmtExamexpend(arguments: arguments),
  "/crmt/examexpend/detail": (context, arguments)=> CrmtExamexpendDetail(arguments: arguments),
  "/crmt/examincome": (context, arguments)=> CrmtExamincome(arguments: arguments),
  "/crmt/examincome/detail": (context, arguments)=> CrmtExamincomeDetail(arguments: arguments),
  "/daily/setclock": (context)=> SetClockPage(),
  "/daily/clock": (context)=> DailyClock(),
  "/daily/clock/record": (context)=> ClockRecord(),
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