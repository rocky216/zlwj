import 'dart:async';
import 'dart:math';

import 'package:amap_location/amap_location.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:gcwyzlwj/components/MyHeader.dart';
import 'package:gcwyzlwj/utils/http.dart';
import 'package:gcwyzlwj/utils/index.dart';
import 'package:permission_handler/permission_handler.dart';



class DailyClock extends StatefulWidget {
  DailyClock({Key key}) : super(key: key);

  @override
  _DailyClockState createState() => _DailyClockState();
}

class _DailyClockState extends State<DailyClock> {
  AMapLocation  _loc;
  StreamSubscription<ConnectivityResult> _connectivitySubscription;
  String heName="";
  String wifiBSSID;
  String wifiIP;
  String wifiName;
  Map data;

  @override
  void initState() { 
    super.initState();
    this.getHe();
    this.getLocation();
    _connectivitySubscription = Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      this.getWifi();
    });
    this.initial();
    
  }

  getHe() async {
    Map userInfo = await getUserInfo();
    if(userInfo != null){
      setState(() {
        heName = userInfo["nowHe"]["name"];
      });
    }
  }

  initial() async {
    var data = await NetHttp.request("/api/app/property/clockRecord/list", context, params: {
      "time": "2020-08-29"
    });
    if(data != null){
      setState(() {
        this.data = data;
      });
    }
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _connectivitySubscription.cancel();
    AMapLocationClient.stopLocation();
  }

  @override
  Widget build(BuildContext context) {
    if(_loc != null){
      var a = _getDistance(27.890089, 114.989708, _loc.longitude, _loc.latitude);
      print(_loc.longitude);
    }
    return Scaffold(
      appBar: MyHeader(
        title: Row(children: <Widget>[Text(heName, style: TextStyle(color: Colors.blue),), Text("考勤打卡")]),
      ),
      body: Container(
        padding: EdgeInsets.all(20.0),
        child: Column(
          children: <Widget>[
            Container(
              child: Column(
                children: <Widget>[
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Icon(Icons.brightness_1, size: 12,),
                        Container(
                          margin: EdgeInsets.only(left: 10.0),
                          child: Row(children: <Widget>[
                            Container(
                              padding: EdgeInsets.fromLTRB(5.0, 0, 5.0, 0),
                              color: Colors.blue,
                              child: Text("上班卡", style: TextStyle(color: Colors.white, fontSize: 12.0),),
                            ),
                            Text("08:00:01")
                          ],),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 20),
                          child: Row(children: <Widget>[
                            Container(
                              padding: EdgeInsets.fromLTRB(5.0, 0, 5.0, 0),
                              color: Colors.blue,
                              child: Text("下班卡", style: TextStyle(color: Colors.white, fontSize: 12.0),),
                            ),
                            Text("08:00:01")
                          ],),
                        ),
                      ],
                    ),
                  ),
                  
                  Container(
                    margin: EdgeInsets.only(top: 50.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Container(
                          child: MaterialButton(
                            onPressed: (){

                            },
                            child: CircleAvatar(
                              backgroundColor: Colors.blue,
                              radius: 40.0,
                              child: Text("上班卡", style: TextStyle(color: Colors.white),),
                            ),
                          ),
                        ),
                        Container(
                          child: MaterialButton(
                            onPressed: (){

                            },
                            child: CircleAvatar(
                              backgroundColor: Colors.grey,
                              radius: 40.0,
                              child: Text("下班卡", style: TextStyle(color: Colors.white),),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  getWifi() async {
   var connectivityResult = await Connectivity().checkConnectivity();
   
   if(connectivityResult == ConnectivityResult.wifi){
     var wifiBSSID = await (Connectivity().getWifiBSSID());
     var wifiIP = await (Connectivity().getWifiIP());
     var wifiName = await (Connectivity().getWifiName());
     setState(() {
       this.wifiBSSID = wifiBSSID;
       this.wifiIP = wifiIP;
       this.wifiName = wifiName;
     });
   }
   
  }

  getLocation() async {
    Map<Permission, PermissionStatus> statuses = await [
      Permission.location,
      Permission.storage,
    ].request();
    
    await AMapLocationClient.startup(new AMapLocationOption( 
      desiredAccuracy:CLLocationAccuracy.kCLLocationAccuracyHundredMeters  ));
      var loc = await AMapLocationClient.getLocation(true);
      setState(() {
        _loc = loc;
      });
    AMapLocationClient.onLocationUpate.listen((AMapLocation loc){
      if(!mounted)return;
      setState(() {
        _loc = loc;
      });
    });
    AMapLocationClient.startLocation();
  }

  _getDistance(double lat1, double lng1, double lat2, double lng2) {
  	double def = 6378137.0;
    double radLat1 = _rad(lat1);
    double radLat2 = _rad(lat2);
    double a = radLat1 - radLat2;
    double b = _rad(lng1) - _rad(lng2);
    double s = 2 * asin(sqrt(pow(sin(a / 2), 2) + cos(radLat1) * cos(radLat2) * pow(sin(b / 2), 2)));
    return (s * def ).roundToDouble();
  }

  double _rad(double d) {
    return d * pi / 180.0;
  }
}