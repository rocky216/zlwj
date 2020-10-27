import 'package:flutter/material.dart';
import 'package:gcyzzlwj/components/MyHeader.dart';
import 'package:gcyzzlwj/components/MyInput.dart';
import 'package:gcyzzlwj/components/MyScrollView.dart';
import 'package:gcyzzlwj/components/MyUploadImg.dart';
import 'package:gcyzzlwj/redux/export.dart';
import 'package:gcyzzlwj/utils/http.dart';
import 'package:gcyzzlwj/utils/index.dart';

class EditUsersPage extends StatefulWidget {
  EditUsersPage({Key key}) : super(key: key);

  @override
  _EditUsersPageState createState() => _EditUsersPageState();
}

class _EditUsersPageState extends State<EditUsersPage> {
  TextEditingController controllerPhone = TextEditingController();
  String avatarUrl;
  String passWord;
  String newPass;
  
  submit() async {
    var data = await NetHttp.request("/api/app/owner/user/updateUserInfo", context, method: "post", params: {
      "passWord": this.passWord,
      "newPass": this.newPass,
      "avatarUrl": this.avatarUrl,
    });
    if(data != null){
      showToast("保存成功！");
      StoreProvider.of<IndexState>(context).dispatch( getUsers(context) );
      Navigator.of(context).pop();
    }
  }

  NetworkImage getImg(users){
    if(this.avatarUrl != null){
      return NetworkImage(this.avatarUrl);
    }
    if( users != null && users["avatarUrl"] != null){
      return NetworkImage(users["avatarUrl"]);
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyHeader(
        title: "个人信息",
        actions: FlatButton(
          onPressed: (){
            this.submit();
          },
          child: Text("保存", style: TextStyle(color: Colors.blue),),
        ),
      ),
      body: MyScrollView(
        child: StoreConnector<IndexState, AppState>(
          onInit: (Store store){
            if(store.state.app.users!=null){
              controllerPhone.text = store.state.app.users["account"];
              
            }
          },
          converter: (store)=>store.state.app,
          builder: (context, state){
            return Container(
              child: Column(
                children: [
                  Container(
                    child: MyUploadImg(
                      next: (url){
                        setState(() {
                          this.avatarUrl = url;
                        });
                      },
                      child: CircleAvatar(
                        radius: 30.0,
                        backgroundColor: Color(0xFFeeeeee),
                        backgroundImage: this.getImg(state.users),
                        child:state.users!=null && state.users["avatarUrl"]!=null?Container():Icon(Icons.person, color: Colors.grey,),
                      ),
                    ),
                  ),
                  MyInput(label: Text("手机号："), controller: controllerPhone, enabled: false,),
                  MyInput(label: Text("原密码："), onChange: (v){
                    setState(() {
                      this.passWord = v;
                    });
                  },),
                  MyInput(label: Text("新密码："), onChange: (v){
                    setState(() {
                      this.newPass = v;
                    });
                  },),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}