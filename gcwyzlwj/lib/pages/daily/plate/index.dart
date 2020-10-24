import 'package:flutter/material.dart';
import 'package:flutter_picker/flutter_picker.dart';
import 'package:gcwyzlwj/components/MyCard.dart';
import 'package:gcwyzlwj/components/MyHeader.dart';
import 'package:gcwyzlwj/components/MyScrollView.dart';
import 'package:gcwyzlwj/pages/daily/plate/data.dart';
import 'package:gcwyzlwj/utils/http.dart';
import 'package:gcwyzlwj/utils/index.dart';

class DailyPlate extends StatefulWidget {
  DailyPlate({Key key}) : super(key: key);

  @override
  _DailyPlateState createState() => _DailyPlateState();
}

class _DailyPlateState extends State<DailyPlate> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  String heName="";
  List<String> platePrefix=["赣","D"];
  String license;
  List data;
  Map info;

  @override
  void initState() { 
    super.initState();
    this.getHe();
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
    var data = await NetHttp.request("/api/app/property/carCarCarpark/countPalte", context, params: {});
    if(data != null){
      setState(() {
        this.data=data;
      });
    }
  }

  getInfo() async {
    var data = await NetHttp.request("/api/app/property/carCarCarpark/plateInfo", context, method: "post", params: {
      "license": (platePrefix[0]+platePrefix[1]+license.toUpperCase()).toString()
    });
    if(data != null){
      setState(() {
        this.info = data;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    print(info);
    return Scaffold(
      key: _scaffoldKey,
      appBar: MyHeader(
        title: Row(children: <Widget>[Text(heName, style: TextStyle(color: Colors.blue),), Text("车牌查询")],),
      ),
      body: MyScrollView(
        child: Column(
          children: <Widget>[
            data==null?Container()
            :Container(
              child: Column(
                children: data.map((f){
                  return MyCard(
                    title: Text(f["parkName"]),
                    child: Row(children: <Widget>[Text("关联车辆：${f['allCount']}"), Text("有效车辆: ${f['validCount']}")],),
                  );
                }).toList(),
              ),
            ),
            MyCard(
              title: Text("车牌查询"),
              child: Container(
                child: Row(
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: Container(
                        alignment: Alignment.center,
                        child: FlatButton(
                          color: Colors.blue,
                          onPressed: (){
                            showPickerArray(context);
                          }, 
                          child: Text(platePrefix[0]+platePrefix[1], style: TextStyle(color: Colors.white),),)
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: TextField(
                        onChanged: (v){
                          setState(() {
                            license=v;
                          });
                        },
                      ),
                    ),
                    Expanded(child: RaisedButton(
                      onPressed: (){
                        if(license == null){
                          showToast("请输入车牌");
                          return;
                        }
                        getInfo();
                      }, 
                    child: Icon(Icons.search),)
                    )
                  ],
                ),
              ),
            ),
            info==null?Container()
            :Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text("联系人信息：${info['linkInfo']}"),
                  Text("业主信息：${info['ownerInfo']}"),
                  Column(
                    children: (info["carCarCarparkList"] as List).map((f){
                      return Container(
                        margin: EdgeInsets.only(top: 10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(f["carparkName"]),
                            Text("有效时间：${f['validStartTime'].substring(0,10)}到${f['validEndTime'].substring(0,10)}")
                          ],
                        ),
                      );
                    }).toList(),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  showPickerArray(BuildContext context) {
    Picker(
        adapter: PickerDataAdapter<String>(
            pickerdata: PickerData,
            isArray: true,
        ),
        hideHeader: true,
        selecteds: [15, 3],
        title: Text("选择车牌", style: TextStyle(fontSize: 14),),
        selectedTextStyle: TextStyle(color: Colors.blue),
        cancel: FlatButton(onPressed: () {
          Navigator.pop(context);
        },
        child: Text("取消")),
        confirmText: "确认",
        onConfirm: (Picker picker, List value) {
          setState(() {
            platePrefix=picker.getSelectedValues();
          });
        }
    ).showDialog(context);
  }
}