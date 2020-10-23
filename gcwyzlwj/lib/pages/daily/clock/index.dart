import 'dart:async';
import 'dart:math';

import 'package:amap_location/amap_location.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:gcwyzlwj/components/MyHeader.dart';
import 'package:gcwyzlwj/components/MyScrollView.dart';
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
  Timer timer;
  bool btn1 = true;
  bool btn2 = true;
  bool isLoc = true;
  

  @override
  void initState() { 
    super.initState();
    this.getHe();
    this.getLocation();
    
    this.initial();
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

  initial() async {
    var data = await NetHttp.request("/api/app/property/clockRecord/list", context, params: {});
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
    timer?.cancel();
  }

  bool setColor(){
    
    if(this.data != null && (this._loc != null || this.wifiName != null)){

      if(_loc != null && _loc.latitude!=null && _loc.longitude != null &&
        _getDistance(double.parse(data["lat"]), double.parse(data["lng"]), _loc.latitude, _loc.longitude)<=data["scope"]){

        return true;
      }else if(this.wifiName != null && data["wifi"] == this.wifiName){
        
        return true;
      }
      return false;
    }
    return false;
  }

  setClock(type) async {
    timer = new Timer(new Duration(seconds: 60), () {
        setDisposal(type, true);
    });
    var data = await NetHttp.request("/api/app/property/clockRecord/addGoWork", context, method: "post", params: {
      "longitude": _loc.longitude,
      "latitude": _loc.latitude,
      "wifi": wifiName,
      "type": type
    });
    if(data != null){
      showToast("打卡成功！");
      initial();
      setDisposal(type, false);
    }
  }

  setDisposal(type, bool status){
    if(type=="goToWork"){
        setState(() {
          btn1=status;
        });
      }else{
        setState(() {
          btn2=status;
        });
      }
  }

  Widget getStatus(f){
    String tips="";
    Color color = Colors.black;
    switch(f["clockStatus"]){
      case "0":
        color=Colors.orange;
        tips="等待打卡";
        break;
      case "1":
        color=Colors.red;
        tips="缺卡";
        break;
      case "2":
        color=Colors.red;
        tips="缺卡";
        break;
      case "3":
        color=Colors.blue;
        break;
    }
    return Container(
            margin: EdgeInsets.only(bottom: 8.0),
            child: Row(
              children: <Widget>[
                Icon(Icons.brightness_1, size: 12, color: color,),
                Container(
                  width: 120.0,
                  margin: EdgeInsets.only(left: 10.0),
                  child: Row(children: <Widget>[
                    Container(
                      padding: EdgeInsets.fromLTRB(5.0, 0, 5.0, 0),
                      color: Colors.blue,
                      child: Text("上班卡", style: TextStyle(color: Colors.white, fontSize: 12.0),),
                    ),
                    f["startClockTime"]!=null?Text(f["startClockTime"].substring(11)):Text(tips, style: TextStyle(color: color, fontSize: 12),)
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
                    f["endClockTime"]!=null?Text(f["endClockTime"].substring(11)):Text(tips, style: TextStyle(color: color, fontSize: 12),)
                  ],),
                ),
              ],
            ),
          );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyHeader(
        title: Row(children: <Widget>[Text(heName, style: TextStyle(color: Colors.blue),), Text("考勤打卡")]),
        actions: FlatButton(onPressed: (){
          Navigator.of(context).pushNamed("/daily/clock/record");
        }, child: Text("考勤记录", style: TextStyle(color: Colors.blue),)),
      ),
      body: MyScrollView(
        child: Container(
          padding: EdgeInsets.all(20.0),
          child: Column(
            children: <Widget>[
              Container(
                child: Column(
                  children: <Widget>[
                    Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: data==null?[]
                        :(data["heClockRecords"] as List).map((f){
                          return getStatus(f);
                        }).toList()
                        
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
                                if(btn1 && setColor()){
                                  setClock("goToWork");
                                }
                                
                              },
                              child: CircleAvatar(
                                backgroundColor: btn1 && setColor()?Colors.blue:Colors.grey,
                                radius: 40.0,
                                child: Text("上班卡", style: TextStyle(color: Colors.white),),
                              ),
                            ),
                          ),
                          Container(
                            child: MaterialButton(
                              onPressed: (){
                                if(btn2 && setColor()){
                                  setClock("goOffWork");
                                }
                                
                              },
                              child: CircleAvatar(
                                backgroundColor: btn2 && setColor()?Colors.blue:Colors.grey,
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
              ),
              Container(
                margin: EdgeInsets.only(top: 20.0),
                child: Text("ps：若无法打卡请顶部下拉打开定位功能！", style: TextStyle(color: Colors.red),),
              )
            ],
          ),
        ),
      ),
    );
  }

  getWifi() async {
   var connectivityResult = await Connectivity().checkConnectivity();
   
   if(connectivityResult == ConnectivityResult.wifi){
     
     var wifiName = await (Connectivity().getWifiName());
     var wifiBSSID = await (Connectivity().getWifiBSSID());
     var wifiIP = await (Connectivity().getWifiIP());
     print(wifiName);
     setState(() {
       this.wifiBSSID = wifiBSSID;
       this.wifiIP = wifiIP;
       this.wifiName = wifiName;
     });
   }
   
  }

  getLocation() async {
      try{
        Map<Permission, PermissionStatus> statuses = await [
        Permission.location,
        Permission.storage,
      ].request();
      //请求信息
      bool isLoc = await Permission.locationWhenInUse.serviceStatus.isEnabled;
      
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
    }catch(e){
      print(e);
    }
    
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
    return (d * pi) / 180.0;
  }
}