import 'package:dio/dio.dart';
import 'package:gcwyzlwj/config/base.dart';

class NetHttp {


  static Dio instance () {
    var dio = Dio();
    dio.options
        ..baseUrl = baseUrl
        ..connectTimeout = 10000
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