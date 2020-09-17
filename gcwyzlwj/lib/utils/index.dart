import 'dart:convert' as convert;
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_image/flutter_native_image.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gcwyzlwj/config/base.dart';
import 'package:gcwyzlwj/pages/index.dart';
import 'package:gcwyzlwj/redux/export.dart';
import 'package:gcwyzlwj/utils/http.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jpush_flutter/jpush_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/services.dart';


Future popconfirm(context, { 
    @required Widget title, 
    Function next,
    Function onCancel, 
    Widget content, 
    Widget confirm,
    Widget cancel,
  }){
  return showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context){
      return AlertDialog(
        title: title,
        content: content!=null?new SingleChildScrollView(
            child: content,
        ):null,
        actions: <Widget>[
          cancel == null?
          new FlatButton(
            child: new Text('取消'),
            onPressed: () {
              if(onCancel !=null){
                onCancel();
              }
              Navigator.of(context).pop();
            },
          ):cancel,
          confirm==null?
          new FlatButton(
            child: new Text('确定'),
            onPressed: () {
              if(next != null){
                next();
              }
              Navigator.of(context).pop();
            },
          ):confirm,
        ],
      );
    }
  );
}

Future<void> initPlatformState(context, {Function next}) async {
  final JPush jpush = new JPush();
    String platformVersion;

    try {
      jpush.addEventHandler(
          onReceiveNotification: (Map<String, dynamic> message) async {
        print("接收通知: $message");
        
      }, onOpenNotification: (Map<String, dynamic> message) async {
        print("打开通知: $message");
        Navigator.of(context).pushNamedAndRemoveUntil("/index", (route)=>false);
        StoreProvider.of<IndexState>(context).dispatch( getNews(context, params: {
          "current": "1"
        }) );
        
      }, onReceiveMessage: (Map<String, dynamic> message) async {
        print("接收消息: $message");
       
      }, onReceiveNotificationAuthorization:
              (Map<String, dynamic> message) async {
        print("授权接收通知: $message");
        
      });
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }

    jpush.setup(
      appKey: "58d210ba92ddb2b79fd84286", //你自己应用的 AppKey
      channel: "theChannel",
      production: false,
      debug: true,
    );
    jpush.applyPushAuthority(
        new NotificationSettingsIOS(sound: true, alert: true, badge: true));

    // Platform messages may fail, so we use a try/catch PlatformException.
    jpush.getRegistrationID().then((rid) {
      if(next !=null){
        next(rid);
      }
      print("获取RegistrationID: $rid");
    });

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    // if (!mounted) return;

  }

/* 上传图片 */
Future uploadImg(type, {next}) async {
  try{

    PickedFile pickedFile;
    if(type=="image"){
      pickedFile = await ImagePicker().getImage(source: ImageSource.gallery);
    }else{
      pickedFile = await ImagePicker().getImage(source: ImageSource.camera);
    }
    File compressedFile = await FlutterNativeImage.compressImage(pickedFile.path,
      quality: 80, percentage: 70); 
    
      FormData formData = new FormData.fromMap({ 
        "fileSize": 1024*10,
        "fileType": "photo",
        "file": await MultipartFile.fromFile(compressedFile.path) //Image.file(image) new File(path)
      });
      Dio dio = new Dio();
      var respone = await dio.post<String>(baseResources+"/resource/file/uploadFile", data: formData);
      if(respone != null){
        var data = convert.jsonDecode(respone.data);
        
        if(data["code"]==0){
          return data["data"];
        }else{
          showToast(data["msg"]);
        }
      }

  }catch(e){
    
  }
  
    
    
}

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

/* 设置 */
void setAgreement() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString("agreem", "1");
}
getAgreement() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var agreem = prefs.getString("agreem");
  
  return agreem;
}
