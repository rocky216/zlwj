
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class LaunchPage extends StatefulWidget {
  LaunchPage({Key key}) : super(key: key);

  @override
  _LaunchPageState createState() => _LaunchPageState();
}

class _LaunchPageState extends State<LaunchPage> {
@override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("启动页"),
      ),
      body: new Center(
        child: Text("sa")
      ),
    );
  }


  // void _checkPersmission() async {
  //   bool hasPermission = 
  //     await SimplePermissions.checkPermission(Permission.WhenInUseLocation);
  // }
}