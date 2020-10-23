import 'package:flutter/material.dart';
import 'package:gcwyzlwj/components/MyHeader.dart';
import 'package:gcwyzlwj/components/MyInput.dart';
import 'package:gcwyzlwj/components/MyScrollView.dart';
import 'package:gcwyzlwj/components/MyUploadImg.dart';
import 'package:gcwyzlwj/redux/export.dart';
import 'package:gcwyzlwj/utils/http.dart';
import 'package:gcwyzlwj/utils/index.dart';
import 'package:smart_select/smart_select.dart';

class AddPersonRepair extends StatefulWidget {
  final arguments;
  AddPersonRepair({Key key, this.arguments}) : super(key: key);

  @override
  _AddPersonRepairState createState() => _AddPersonRepairState();
}

class _AddPersonRepairState extends State<AddPersonRepair> {
  String value = 'flutter';
List imgUrls=[];
List types=[];
String repairTypeId;
String repairName;
String repairInfo;


@override
void initState() { 
  super.initState();
  this.getTypes();
}
getTypes() async {
  var data = await NetHttp.request("/api/app/he/repair/repairType", context, params: {});
  if(data != null){
    setState(() {
      types=data;
    });
  }
}

  myAdd(){
    return Container(
      margin: EdgeInsets.only(left: 10.0),
      child: MyUploadImg(
        next: (url){
          imgUrls.add(url);
          setState(() {
            imgUrls = imgUrls;
          });
        },
        child: Container(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(6.0),
            child: Container(
              width: 60.0,
              height: 60.0,
              color: Color(0xFFdddddd),
              child: Icon(Icons.add, color: Colors.grey, size: 30,),
            ),
          ),
        ),
      ),
    );
  }

  submit() async {
    var data = NetHttp.request("/api/app/property/repair/add", context, method: "post", params: {
      "repairTypeId": repairTypeId,
      "repairName": repairName,
      "repairInfo": repairInfo,
      "imgUrls": imgUrls.join(","),
    });
    if(data !=null){
      showToast("添加成功！");
      Navigator.of(context).pop();
      if(widget.arguments["type"]=="userAll"){
        StoreProvider.of<IndexState>(context).dispatch( getPersonRepair(context, params: {
          "current": 1,
          "type": "userAll"
        }));
      }
      
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyHeader(
        isHe: true,
        title: Text("创建报修"),
        actions: MaterialButton(onPressed: (){
          submit();
        }, child: Text("保存", style: TextStyle(color: Colors.blue),),),
      ),
      body: MyScrollView(
        child: Column(
          children: <Widget>[
            SmartSelect<String>.single(
              title: '报修类型',
              placeholder: "请选择报修类型",
              value: repairTypeId,
              options: types.map((f){
                return SmartSelectOption<String>(value: f["id"].toString(), title: f["dictLabel"]);
              }).toList(),
              onChange: (val){
                print(val);
                setState((){
                  repairTypeId = val;
                });
              }
            ),
            MyInput(label: Text("标题："), onChange: (v){
              setState(() {
                repairName=v;
              });
            },),
            MyInput(label: Text("描述："), maxLines: 4, padding: EdgeInsets.only(top: 10.0, bottom: 10.0),onChange: (v){
              setState(() {
                repairInfo=v;
              });
            },),
            MyInput(label: Text("上传图片："),
              padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
              child: Wrap(
                children: imgUrls.map((f){
                  return Container(
                    margin: EdgeInsets.fromLTRB(10.0, 0, 0, 10.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(6.0),
                      child: Container(
                        width: 60.0,
                        height: 60.0,
                        color: Colors.grey,
                        child: Image.network(f, fit: BoxFit.cover),
                      ),
                    ),
                  );
                }).toList()
                ..add(myAdd()),
              ),
            ),
          ],
        ),
      ),
    );
  }
}