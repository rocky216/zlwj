
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gcyzzlwj/components/MyShowImage.dart';
import 'package:gcyzzlwj/pages/auth/login.dart';
import 'package:gcyzzlwj/pages/call/index.dart';
import 'package:gcyzzlwj/pages/clean/add.dart';
import 'package:gcyzzlwj/pages/clean/detail.dart';
import 'package:gcyzzlwj/pages/clean/index.dart';
import 'package:gcyzzlwj/pages/control/index.dart';
import 'package:gcyzzlwj/pages/govern/detail.dart';
import 'package:gcyzzlwj/pages/govern/index.dart';
import 'package:gcyzzlwj/pages/hall/Detail.dart';
import 'package:gcyzzlwj/pages/hall/index.dart';
import 'package:gcyzzlwj/pages/index.dart';
import 'package:gcyzzlwj/pages/launch/index.dart';
import 'package:gcyzzlwj/pages/notice/index.dart';
import 'package:gcyzzlwj/pages/pay/pile.dart';
import 'package:gcyzzlwj/pages/pile/index.dart';
import 'package:gcyzzlwj/pages/plate/index.dart';
import 'package:gcyzzlwj/pages/visitor/index.dart';
import 'package:gcyzzlwj/pages/visitor/visitor.dart';

var routes = {
  "/index": (context)=>IndexPage(),
  "/login": (context)=>LoginPage(),
  "/launch": (context)=>LaunchPage(),
  "/notice": (context)=>NoticePage(),
  "/hall": (context)=>HallPage(),
  "/hall/detial": (context, arguments)=>DisHallDetailPage(arguments: arguments,),
  "/clean": (context)=>CleanPage(),
  "/addclean": (context)=>AddCleanPage(),
  "/clean/detail": (context, arguments)=>CleanDetailPage(arguments: arguments,),
  "/call": (context)=>CallPage(),
  "/paypile": (context, arguments)=>PayPilePage(arguments:arguments),
  "/govern": (context) => GovernPage(),
  "/govern/detail": (context, arguments)=>GovernDetailPage(arguments: arguments,),
  "/visitor": (context)=>VisitorPage(),
  "/tovisitor": (context)=>ToVisitorPage(),
  "/control": (context)=>ControlPage(),
  "/pile": (context)=>PilePage(),
  "/plate": (context)=>PlatePage(),
  "/showimg": (context, arguments)=>MyShowImage(arguments: arguments,)
  
  
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