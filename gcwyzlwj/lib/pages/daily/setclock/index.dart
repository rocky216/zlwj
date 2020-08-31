import 'dart:async';

import 'package:amap_location/amap_location.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:gcwyzlwj/components/MyBetweeItem.dart';
import 'package:gcwyzlwj/components/MyHeader.dart';
import 'package:gcwyzlwj/components/MyScrollView.dart';
import 'package:gcwyzlwj/utils/http.dart';
import 'package:gcwyzlwj/utils/index.dart';
import 'package:permission_handler/permission_handler.dart';

class SetClockPage extends StatefulWidget {
  SetClockPage({Key key}) : super(key: key);

  @override
  _SetClockPageState createState() => _SetClockPageState();
}

class _SetClockPageState extends State<SetClockPage> {
  String heName="";
  AMapLocation  _loc;
  StreamSubscription<ConnectivityResult> _connectivitySubscription;
  String wifiBSSID="";
  String wifiIP="";
  String wifiName="";

  @override
  void initState() { 
    super.initState();
    this.getHe();
    this.getLocation();
    _connectivitySubscription = Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      this.getWifi();
    });
  }

  getHe() async {
    Map userInfo = await getUserInfo();
    if(userInfo != null){
      setState(() {
        heName = userInfo["nowHe"]["name"];
      });
    }
  }
  @override
  dispose(){
    super.dispose();
    _connectivitySubscription.cancel();
    AMapLocationClient.stopLocation();
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

  submit() async {
    if(_loc==null || wifiName.isEmpty){
      showToast("信息不全不能设置打卡");
      return;
    }
    var data = await NetHttp.request("/api/app/property/clock/addOrUpdate", context, method: "post",
      params: {
        "wifi": wifiName,
        "wifiIp": wifiIP,
        "wifiBssId": wifiBSSID,
        "longitude": _loc!=null?_loc.longitude.toString():"",
        "latitude": _loc!=null?_loc.latitude.toString():"",
      });
      if(data!=null){
        showToast("设置成功！");
        Navigator.of(context).pop();
      }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyHeader(
        title: Row(children: <Widget>[Text(heName, style: TextStyle(color: Colors.blue),),Text("打卡设置")],),
        actions: FlatButton(
          onPressed: (){
            this.submit();
          }, 
          child: Text("保存设置", style: TextStyle(color: Colors.blue, fontWeight: FontWeight.w600),)),
      ),
      body: MyScrollView(
        child: Container(
          padding: EdgeInsets.all(20.0),
          child: Column(
            children: <Widget>[
              Container(
                child: Column(
                  children: <Widget>[
                    MyBetweeItem(title: "wifi名称", value: wifiName,),
                    MyBetweeItem(title: "wifiIP", value: wifiIP,),
                    MyBetweeItem(title: "wifiBSSID", value: wifiBSSID,),
                  ],
                ),
              ),
              _loc==null?Container(
                child: Text("正在定位..."),
              )
              :Container(
                margin: EdgeInsets.only(top:30.0),
                child: Column(
                  children: <Widget>[
                    MyBetweeItem(title: "经度", value: _loc.longitude.toString(),),
                    MyBetweeItem(title: "纬度", value: _loc.latitude.toString(),),
                    Container(
                      margin: EdgeInsets.only(top: 15.0),
                      child: Text(_loc.formattedAddress),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}