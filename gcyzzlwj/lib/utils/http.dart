import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gcyzzlwj/config/index.dart';
import 'dart:convert' as convert;

import 'package:gcyzzlwj/utils/index.dart';

class NetHttp {

  static showToast(msg){
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

  static Future<T> request<T> (String url, context, {
    String method="get",
    @required Map<String, dynamic> params,
    contentType,
  }) async {
    /* 配置网络配置 */
    
    final options = Options(method: method);
    final userInfo = await getUserInfo();
  
    params["token"] = userInfo!= null?userInfo["token"]:null;
    try{
      EasyLoading.show();
      Response response = await instance().request(
        baseUrl+url, 
        queryParameters: params,
        options: options
      );

      if(response.data is String){
        response.data = convert.jsonDecode(response.data);
      }
      
      if(response.data["code"] == 2){
        removeUserInfo();
        Navigator.of(context).pushNamedAndRemoveUntil("/login", (route)=>false );
      }else if(response.data["code"] == 0 || response.data["code"] == -1){
        showToast(response.data["msg"]);
        response.data["data"] = null;
      }else if( response.data["code"] == 1 && response.data["data"] == null){
        response.data["data"] = {};
      }
      EasyLoading.dismiss();
      return response.data["data"];
    } on DioError catch(e){
      EasyLoading.dismiss();
      return Future.error(e);
    }

  }


  static Dio instance () {
    var dio = Dio();
    dio.options
        ..baseUrl = baseUrl
        ..connectTimeout = 100000
        ..receiveTimeout = 5000
        ..validateStatus = (int status){
          return status>0;
        };

    dio.interceptors
        ..add(
          InterceptorsWrapper(
            onRequest: (Options options){
              return options;
            }
          )
        )
        ..add(
          LogInterceptor( requestBody: false )
        );
    
    return dio;
  }



}