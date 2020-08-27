import 'package:amap_location/amap_location.dart';
import 'package:flutter/material.dart';
import 'package:gcwyzlwj/components/MyHeader.dart';
import 'package:permission_handler/permission_handler.dart';

class ClockPage extends StatefulWidget {
  ClockPage({Key key}) : super(key: key);

  @override
  _ClockPageState createState() => _ClockPageState();
}

class _ClockPageState extends State<ClockPage> with SingleTickerProviderStateMixin {
  AMapLocation  _loc;

  @override
  void initState() { 
    super.initState();
    this.getLocation();
  }
  

  @override
  void dispose() { 
    super.dispose();
    AMapLocationClient.stopLocation();
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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyHeader(
        title: Text("打卡"),
      ),
      body: new Center(
        child: Column(
          children: <Widget>[
            Divider(),
            _loc == null
            ? Text("正在定位")
            : Text("定位成功：${_loc.formattedAddress}"),
          ],
        ),
    )
    );
  }
}