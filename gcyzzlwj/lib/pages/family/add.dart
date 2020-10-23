import 'package:flutter/material.dart';
import 'package:gcyzzlwj/components/MyBetweeItem.dart';
import 'package:gcyzzlwj/components/MyHeader.dart';
import 'package:gcyzzlwj/components/MyInput.dart';
import 'package:gcyzzlwj/components/MyScrollView.dart';
import 'package:gcyzzlwj/redux/export.dart';
import 'package:gcyzzlwj/utils/http.dart';
import 'package:gcyzzlwj/utils/index.dart';
import 'package:smart_select/smart_select.dart';

class AddFamilyPage extends StatefulWidget {
  final arguments;
  AddFamilyPage({Key key, this.arguments}) : super(key: key);

  @override
  _AddFamilyPageState createState() => _AddFamilyPageState();
}

class _AddFamilyPageState extends State<AddFamilyPage> {

  String ownerType;
  String name;
  String phone;

  submit() async {
    var data = await NetHttp.request("/api/app/owner/my/addMember", context, method: "post", params: {
      "id": widget.arguments["id"].toString(),
      "type": widget.arguments["type"]=="1"?"house":"shops",
      "name": this.name,
      "phone": this.phone,
      "ownerType": this.ownerType
    });
    if(data != null){
      Navigator.of(context).pop();
      showToast("添加成功！");
      StoreProvider.of<IndexState>(context).dispatch( getFamilyList(context) );
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyHeader(
        title: "添加成员",
        actions: FlatButton(
          onPressed: (){
            this.submit();
          },
          child: Text("保存"),
        ),
      ),
      body: MyScrollView(
        child: Container(
          padding: EdgeInsets.all(10.0),
          child: Column(
            children: [
              SmartSelect.single(
                placeholder: "类型",
                value: this.ownerType, 
                title: "类型", 
                choiceItems: [
                  S2Choice<String>(value: "1", title: "家庭成员"),
                  S2Choice<String>(value: "2", title: "租客"),
                ],
                onChange: (v){
                  setState(() {
                    this.ownerType = v.value.toString();
                  });
                }
              ),

              MyInput(label: Text("姓名："), onChange: (v){
                setState(() {
                  this.name = v;
                });
              },),
              MyInput(label: Text("手机号："), onChange: (v){
                setState(() {
                  this.phone = v;
                });
              },),
            ],
          ),
        ),
      ),
    );
  }
}