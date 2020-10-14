import 'package:flutter/cupertino.dart';

class AppState {
  Map home;
  List helist;
  Map userale;
  Map users;

  AppState({this.home, this.helist, this.userale, this.users});

  factory AppState.initial(){
    return AppState();
  }
}