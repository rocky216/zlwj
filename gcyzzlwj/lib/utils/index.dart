import 'dart:convert' as convert;
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_native_image/flutter_native_image.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gcyzzlwj/config/index.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jpush_flutter/jpush_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';


Future<void> initPlatformState(context, {Function next}) async {
  final JPush jpush = new JPush();
    String platformVersion;

    try {
      jpush.addEventHandler(
          onReceiveNotification: (Map<String, dynamic> message) async {
        print("接收通知: $message");
        
      }, onOpenNotification: (Map<String, dynamic> message) async {
        print("打开通知: $message");
        try{
          Map map = convert.jsonDecode(message["extras"]["cn.jpush.android.EXTRA"]);
          String type = map["type"];

          switch(type){
            case "cdz":
              Navigator.of(context).pushNamed("/pile/order");
              break;
            case "cdz":
              Navigator.of(context).pushNamed("/plate/order");
              break;
            case "yst":
              Navigator.of(context).pushNamed("/hall");
              break;
          }

        }catch(e){
          print(e);
        }
        
        
        
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
      appKey: "1c238442888df896a66fb859", //你自己应用的 AppKey
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
    
    if(Platform.isAndroid){
      var d  = await jpush.isNotificationEnabled();
      if(!d){
        confirmDialog(context, title: Text("请打开通知权限"), ok: (){
          jpush.openSettingsForNotification();
        });
      }
    }
    
    

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    // if (!mounted) return;

  }

confirmDialog(context, {Widget title, Widget content, Function ok, Function onCancel}){
  return showDialog(
    context: context,
    builder: (context) {
      return CupertinoAlertDialog(
        title: title,
        content: content,
        actions: <Widget>[
          FlatButton(
            onPressed: () {
              Navigator.of(context).pop();
              if(onCancel != null){
                onCancel();
              }
            },
            child: Text('取消'),
          ),
          FlatButton(
            onPressed: () {
              Navigator.of(context).pop();
              if(ok != null){
                ok();
              }
            },
            child: Text('确定'),
          ),
        ],
      );
    },
  );
}

// 4 订单负载丢失结束(已扣款) (orderStatus = 3 && truePayFee > 0)
// 5 订单正常结束(orderStatus = 2 && (endStatus = 6 || endStatus = 2 || endStatus = 1 || endStatus = 3 || endStatus  = 4))
// 6 订单过载结束(orderStatus = 2 && (endStatus = 5))
// 7 订单设备重启结束(orderStatus = 2 && (endStatus = 9))

/* 结束状态 */
Widget endStatus(Map map ){
  if(map["orderStatus"] == "3" && map["truePayFee"]>0){
    return Text("订单负载丢失结束(已扣款)", style: TextStyle(color: Colors.red),);
  }else if(map["orderStatus"] == "2" && (map["endStatus"] == "6" || map["endStatus"] == "2" || map["endStatus"] == "1" 
    || map["endStatus"] == "3" || map["endStatus"] == "4" )){
      return Text("订单正常结束", style: TextStyle(color: Colors.blue),);
  }else if(map["orderStatus"] == "2" && map["endStatus"] == "5"){
    return Text("订单过载结束", style: TextStyle(color: Colors.red),);
  }else if(map["orderStatus"] == "2" && map["endStatus"] == "9"){
    return Text("订单设备重启结束", style: TextStyle(color: Colors.red),);
  }
  return Container();

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
      EasyLoading.show();
      var respone = await dio.post<String>(baseResources+"/resource/file/uploadFile", data: formData);
      EasyLoading.dismiss();
      if(respone != null){
        var data = convert.jsonDecode(respone.data);
        
        if(data["code"]==0){
          return data["data"];
        }else{
          showToast(data["msg"]);
        }
      }
      
  }catch(e){
    EasyLoading.dismiss();
  }
}

//获取索引
int getIndexOf(List arr, attr, str){
  int index = -1;
  arr.asMap().forEach((k,v){
    if(v[attr]==str){
      index = k;
    }
  });
  return index;
}

/* 扫码解析跳转 */
scanJump(context, String result){
  try{

    String str = result.split("?")[1];
    List arr = str.split("=");
    
    switch( arr[0] ){
      case "cdz": //充电桩
        Navigator.of(context).pushNamed("/paypile", arguments: {
          "type": arr[0],
          "code": arr[1],
          "content": result
        });
        break;
      case "iotId": //车牌
        Navigator.of(context).pushNamed("/payplate", arguments: {
          "type": arr[0],
          "code": arr[1],
          "content": result
        });
        break;
    }

  }catch(e){
    print(e);
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
