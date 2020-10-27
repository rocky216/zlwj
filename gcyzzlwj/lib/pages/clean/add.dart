import 'package:flutter/material.dart';
import 'package:gcyzzlwj/components/MyBigImg.dart';
import 'package:gcyzzlwj/components/MyHeader.dart';
import 'package:gcyzzlwj/components/MyInput.dart';
import 'package:gcyzzlwj/components/MyScrollView.dart';
import 'package:gcyzzlwj/components/MyUploadImg.dart';
import 'package:gcyzzlwj/redux/export.dart';
import 'package:gcyzzlwj/utils/http.dart';
import 'package:gcyzzlwj/utils/index.dart';
import 'package:smart_select/smart_select.dart';

class AddCleanPage extends StatefulWidget {
  AddCleanPage({Key key}) : super(key: key);

  @override
  _AddCleanPageState createState() => _AddCleanPageState();
}

class _AddCleanPageState extends State<AddCleanPage> {
  List imgUrls=[];
  List repairTypelist = [];
  String repairTypeId;
  String repairName;
  String repairInfo;

  @override
  void initState() { 
    super.initState();
    this.getTypes();
  }

  getTypes() async {
    var data = await NetHttp.request("/api/app/owner/myJournal/repairType", context, params: {});
    if(data != null){
      setState(() {
        this.repairTypelist = data;
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
    var data = await NetHttp.request("/api/app/owner/myJournal/repairAdd", context, method: "post", params: {
      "repairTypeId": this.repairTypeId,
      "repairName": this.repairName,
      "repairInfo": this.repairInfo,
      "imgUrls": this.imgUrls.join(","),
    });
    
    if(data != null){
      Navigator.of(context).pop();
      showToast("提交成功!");
      StoreProvider.of<IndexState>(context).dispatch(getCleanList(context, params: {
        "current": "1"
      }));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyHeader(
        title: "创建报修单",
        actions: FlatButton(
          onPressed: (){
            this.submit();
          },
          child: Text("保存", style: TextStyle(color: Colors.blue),),
        ),
      ),
      body: MyScrollView(
        child: Column(
          children: [
            SmartSelect.single(
              placeholder: "选择报修类型",
              value: "ion", 
              title: "选择报修类型", 
              choiceItems: this.repairTypelist.map((f){
                return S2Choice<String>(value: f["id"].toString(), title: f["dictLabel"]);
              }).toList(),
              onChange: (v){
                setState(() {
                  this.repairTypeId = v.value.toString();
                });
              }
            ),
            MyInput(label: Text("报修标题："), onChange: (v){
              setState(() {
                this.repairName = v;
              });
            },),
            MyInput(label: Text("报修说明："), maxLines: 3, padding: EdgeInsets.only(top: 10.0, bottom: 10.0), onChange: (v){
              setState(() {
                this.repairInfo = v;
              });
            },),
            MyInput(label: Text("选择图片："), 
              child: Wrap(
                children: imgUrls.map((f){
                  return Container(
                    margin: EdgeInsets.fromLTRB(10.0, 0, 0, 10.0),
                    child: MyBigImg(
                      imgUrl: f, 
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(6.0),
                        child: Container(
                          width: 60.0,
                          height: 60.0,
                          color: Colors.grey,
                          child: Image.network(f, fit: BoxFit.cover),
                        ),
                      )
                    ),
                  );
                }).toList()
                ..add( myAdd() )
              ),
              padding: EdgeInsets.fromLTRB(0, 10, 0, 10),),
          ],
        ),
      ),
    );
  }
}