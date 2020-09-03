import 'dart:convert' as convert;
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_image/flutter_native_image.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gcwyzlwj/config/base.dart';
import 'package:gcwyzlwj/utils/http.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';


/* 上传图片 */
Future uploadImg(type, {next}) async {
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
