import 'dart:isolate';
import 'dart:ui';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';


class MyDownLoad extends StatefulWidget {
  final Widget child;
  final String url;
  final Function next;
  MyDownLoad({Key key, @required this.url, @required this.child, this.next}) : super(key: key);

  @override
  _MyDownLoadState createState() => _MyDownLoadState();
}

class _MyDownLoadState extends State<MyDownLoad> {
  String url = "https://upload.wikimedia.org/wikipedia/commons/6/60/The_Organ_at_Arches_National_Park_Utah_Corrected.jpg";
  String _localPath;
  bool _permissionReady;
  ReceivePort _port = ReceivePort();
  String progress;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _bindBackgroundIsolate();
    FlutterDownloader.registerCallback(downloadCallback);
    
  }

  static void downloadCallback(String id, DownloadTaskStatus status, int progress) {
    final SendPort send = IsolateNameServer.lookupPortByName('downloader_send_port');
    send.send([id, status, progress]);
  }
  void _bindBackgroundIsolate() {
    bool isSuccess = IsolateNameServer.registerPortWithName(
        _port.sendPort, 'downloader_send_port');
    if (!isSuccess) {
      _unbindBackgroundIsolate();
      _bindBackgroundIsolate();
      return;
    }
    _port.listen((dynamic data) {
      String id = data[0];
      DownloadTaskStatus status = data[1];
      print(data);
      setState(() {
        progress = data[2].toString();
      });
      
      // final task = _tasks?.firstWhere((task) => task.taskId == id);
      // if (task != null) {
      //   setState(() {
      //     task.status = status;
      //     task.progress = progress;
      //   });
      // }
    });
  }
  void _unbindBackgroundIsolate() {
    IsolateNameServer.removePortNameMapping('downloader_send_port');
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _unbindBackgroundIsolate();
  }

  
  @override
  Widget build(BuildContext context) {
    
    return Container(
      child: GestureDetector(
        child:progress==null? widget.child : 
        Container(
          padding: EdgeInsets.all(10.0),
          child: Text("正在下载，请稍后...${this.progress}%", style: TextStyle(color: Colors.blue),
        ),),
        onTap: () async {
          await _prepare();
          final taskId = await FlutterDownloader.enqueue(
            url: widget.url,
            savedDir: _localPath,
            showNotification: true, // show download progress in status bar (for Android)
            openFileFromNotification: true, // click on notification to open downloaded file (for Android)
          );
        },
      ),
    );
  }

  Future<Null> _prepare() async {
    _permissionReady = await _checkPermission();
    _localPath = (await _findLocalPath()) + Platform.pathSeparator + 'Download';
    
    final savedDir = Directory(_localPath);
    bool hasExisted = await savedDir.exists();
    if (!hasExisted) {
      savedDir.create();
    }
  }

  Future<bool> _checkPermission() async {
    if (Platform.isAndroid) {
      final status = await Permission.storage.status;
      if (status != PermissionStatus.granted) {
        final result = await Permission.storage.request();
        if (result == PermissionStatus.granted) {
          return true;
        }
      } else {
        return true;
      }
    } else {
      return true;
    }
    return false;
  }

  Future<String> _findLocalPath() async {
    final directory = await getExternalStorageDirectory();
    return directory.path;
  }
}