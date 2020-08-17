import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gcwyzlwj/pages/index.dart';
import 'package:gcwyzlwj/pages/launch/index.dart';

var routes = {
  "/index": (context)=> IndexPage(),
  "/launch": (context)=> LaunchPage()
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