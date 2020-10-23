import 'package:flutter/material.dart';
import 'package:gcwyzlwj/components/MyHeader.dart';
import 'package:gcwyzlwj/components/MyInput.dart';
import 'package:gcwyzlwj/components/MyScrollView.dart';
import 'package:gcwyzlwj/redux/export.dart';
import 'package:gcwyzlwj/utils/http.dart';
import 'package:gcwyzlwj/utils/index.dart';

class SetPassword extends StatefulWidget {
  SetPassword({Key key}) : super(key: key);

  @override
  _SetPasswordState createState() => _SetPasswordState();
}

class _SetPasswordState extends State<SetPassword> {

  String oldPassword;
  String newPassword;
  String rePassword;

  submit() async {
    if(newPassword != rePassword){
      showToast("密码不一致！");
      return;
    }
    var data = await NetHttp.request("/api/app/property/message/updatePassword", context, method: "post", params: {
      "account": StoreProvider.of<IndexState>(context).state.app.user["account"],
      "oldPassword": oldPassword,
      "newPassword": newPassword,
    });
    if(data != null){
      showToast("密码修改成功！");
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyHeader(
        title: Text("设置密码"),
        actions: MaterialButton(
          onPressed: (){
            submit();
          },
          child: Text("保存", style: TextStyle(color: Colors.blue,),),
        ),
      ),
      body: MyScrollView(
        child: Container(
          child: StoreConnector<IndexState, Map>(
            converter: (store)=>store.state.app.user,
            builder: (BuildContext context, state){
              
              return Column(
                children: <Widget>[
                  MyInput(label: Text("账号："),
                    child: Container(
                      padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                      child: Text(state["account"]),
                    ),
                  ),
                  MyInput(label: Text("原密码："),
                    onChange: (v){
                      setState(() {
                        this.oldPassword = v;
                      });
                    },
                  ),
                  MyInput(label: Text("新密码："),
                    onChange: (v){
                      setState(() {
                        this.newPassword = v;
                      });
                    },
                  ),
                  MyInput(label: Text("重置密码："),
                    onChange: (v){
                      setState(() {
                        this.rePassword = v;
                      });
                    },
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}