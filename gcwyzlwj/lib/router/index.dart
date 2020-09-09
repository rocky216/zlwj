import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gcwyzlwj/components/MyShowImage.dart';
import 'package:gcwyzlwj/pages/auth/agreement.dart';
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
import 'package:gcwyzlwj/pages/daily/inspect/add.dart';
import 'package:gcwyzlwj/pages/daily/inspect/index.dart';
import 'package:gcwyzlwj/pages/daily/patrol/detail.dart';
import 'package:gcwyzlwj/pages/daily/patrol/index.dart';
import 'package:gcwyzlwj/pages/daily/patrol/recordDetail.dart';
import 'package:gcwyzlwj/pages/daily/plate/index.dart';
import 'package:gcwyzlwj/pages/daily/setclock/index.dart';
import 'package:gcwyzlwj/pages/index.dart';
import 'package:gcwyzlwj/pages/launch/index.dart';
import 'package:gcwyzlwj/pages/news/detail.dart';
import 'package:gcwyzlwj/pages/repair/all/detail.dart';
import 'package:gcwyzlwj/pages/repair/all/index.dart';
import 'package:gcwyzlwj/pages/repair/person/add.dart';
import 'package:gcwyzlwj/pages/repair/person/detail.dart';
import 'package:gcwyzlwj/pages/repair/person/index.dart';
import 'package:gcwyzlwj/pages/user/userInfo.dart';


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
  "/daily/plate": (context)=> DailyPlate(),
  "/daily/patrol": (context)=> DailyPatrol(),
  "/daily/patroldetail": (context, arguments)=> PatrolDetail(arguments: arguments),
  "/daily/patrolrecord/detail": (context, arguments)=> PatrolRecordDetail(arguments: arguments),
  "/daily/inspect": (context)=> DailyInspect(),
  "/daily/inspect/add": (context)=> AddDailyInspect(),
  "/repair/person": (context)=> PersonRepair(),
  "/repair/person/add": (context, arguments)=> AddPersonRepair(arguments: arguments),
  "/repair/all": (context)=> AllRepair(),
  "/user/userinfo": (context)=>UserInfoPage(),
  "/news/detail": (context, arguments)=>NewDetailPage(arguments: arguments),
  "/repair/alldetail": (context, arguments)=>RepairDetailPage(arguments: arguments),
  "/repair/persondetail": (context, arguments)=>RepairPersonDetailPage(arguments: arguments),
  "/showimg": (context, arguments)=>MyShowImage(arguments: arguments),
  "/agreement": (context)=>UserAgreement()
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