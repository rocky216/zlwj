import 'package:amap_location/amap_location.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class LaunchPage extends StatefulWidget {
  LaunchPage({Key key}) : super(key: key);

  @override
  _LaunchPageState createState() => _LaunchPageState();
}

class _LaunchPageState extends State<LaunchPage> {
AMapLocation  _loc;
@override
  void initState() {
    // TODO: implement initState
    super.initState();
    this.getLocation();
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
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    AMapLocationClient.stopLocation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("启动页"),
      ),
      body: new Center(
        child: _loc == null
        ? Text("正在定位")
        : Text("定位成功：${_loc.formattedAddress}"),
      ),
    );
  }


  // void _checkPersmission() async {
  //   bool hasPermission = 
  //     await SimplePermissions.checkPermission(Permission.WhenInUseLocation);
  // }
}