import 'package:flutter/material.dart';
import 'package:gcwyzlwj/components/MyHeader.dart';
import 'package:gcwyzlwj/components/MyInput.dart';
import 'package:gcwyzlwj/components/MyScrollView.dart';
import 'package:gcwyzlwj/redux/export.dart';
import 'package:gcwyzlwj/utils/http.dart';
import 'package:gcwyzlwj/utils/index.dart';

class UserInfoPage extends StatefulWidget {
  UserInfoPage({Key key}) : super(key: key);

  @override
  _UserInfoPageState createState() => _UserInfoPageState();
}

class _UserInfoPageState extends State<UserInfoPage> {
  
  String url;
  /* 姓名 */
  TextEditingController nameController = TextEditingController();
  /* 昵称 */
  TextEditingController nickNameController = TextEditingController();
  /* 手机号 */
  TextEditingController phoneController = TextEditingController();

  @override
  void initState() { 
    super.initState();
    
  }

  submit() async {
    var data = NetHttp.request("/api/app/property/message/updateUserInfo", context, method: "post", params: {
      "nickName": nickNameController.text,
      "phone": phoneController.text,
      "headUrl": this.url??"",
    });
    if(data != null){
      showToast("修改成功！");
      Navigator.of(context).pop();
      StoreProvider.of<IndexState>(context).dispatch( getUsers(context, params: {}) );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyHeader(
        title: Text("我的基本信息"),
        actions: MaterialButton(
          onPressed: (){
            submit();
          },
          child: Text("保存", style: TextStyle(color: Colors.blue),),
        ),
      ),
      body: MyScrollView(
        child: Container(
          padding: EdgeInsets.all(10.0),
          child: StoreConnector<IndexState, Map>(
            onInit: (Store store){
              var data = store.state.app.user;
              if(data !=null){
                nameController.text=data["name"];
                nickNameController.text=data["nickName"];
                phoneController.text=data["phone"];
              }
              
            },
            converter:(store)=>store.state.app.user,
            builder: (BuildContext context, state){
              return Column(
                children: <Widget>[
                  MyInput(
                    label: Text("头像:"),
                    child: Row(
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.fromLTRB(10.0, 10.0, 0, 10.0),
                          child: MaterialButton(
                            onPressed: () async {
                              var url = await uploadImg("image");
                              print(url);
                              setState(() {
                                this.url = url;
                              });
                            },
                            child: CircleAvatar(
                              radius: 30.0,
                              backgroundColor: Color(0xFFeeeeee),
                              backgroundImage: url==null? 
                              state["userHeadUrl"].isEmpty?null:NetworkImage(state["userHeadUrl"])
                              :NetworkImage(url),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  MyInput(
                    label: Text("员工姓名:"),
                    enabled: false,
                    controller: nameController,
                  ),
                  MyInput(
                    label: Text("昵称:"),
                    controller: nickNameController,
                  ),
                  MyInput(
                    label: Text("手机号:"),
                    controller: phoneController,
                  ),
                ],
                
              );
            },),
        ),
      ),
    );
  }
}