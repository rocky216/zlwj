import 'dart:convert' as convert;
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';




/* 提示框 */
showToast(msg){
  Fluttertoast.showToast(
    msg: msg,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.CENTER,
    timeInSecForIosWeb: 1,
    backgroundColor: Color(0x90000000),
    textColor: Colors.white,
    fontSize: 16.0
  );
}

/* 获取用户信息 */
Future<Map<String, dynamic>> getUserInfo() async {
  try{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String mapStr = prefs.getString("userInfo");
    return convert.jsonDecode(mapStr);
  } catch(e){
    return null;
  }
  
}

/* 存储用户信息 */
void setUserInfo(Map<String, dynamic> map) async {
  try{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String mapStr = convert.jsonEncode(map);
    prefs.setString("userInfo", mapStr);
  }catch(e){
    return Future.error(e);
  }
}

/* 清楚用户信息 */
void removeUserInfo() async {
  try{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove("userInfo");
  }catch(e){
    return Future.error(e);
  }
}
