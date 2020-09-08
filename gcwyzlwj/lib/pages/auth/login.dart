import 'package:flutter/material.dart';
import 'package:gcwyzlwj/components/MyHeader.dart';
import 'package:gcwyzlwj/components/MyScrollView.dart';
import 'package:gcwyzlwj/utils/http.dart';
import 'package:gcwyzlwj/utils/index.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  /* 表单状态 */
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _phone;
  String _password;

  goLogin() async {
    
    var data =  await NetHttp.request<Map>("/api/app/property/login", context, method: "post", 
      params: {"account": _phone, "passWord": _password});
      
    if(data!=null){
      await setUserInfo(data);
      print(111);
      Navigator.of(context).pushNamedAndRemoveUntil("/index", (route)=>false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyHeader(
        title: Container(
          margin: EdgeInsets.only(left: 10.0),
          child: Text("用户登录"),
        ),
      ),
      body: MyScrollView(
        child: Container(
          padding: EdgeInsets.fromLTRB(20, 20, 30, 0),
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                TextFormField(
                  decoration: InputDecoration(
                    labelText: "用户名字",
                    hintText: "请输入用户名字！",
                    icon: Icon(Icons.person),
                  ),
                  validator: (v){
                    return v.trim().length>0?null:"用户名字不能为空！";
                  },
                  onChanged: (v){
                    setState(() {
                      _phone = v;
                    });
                  },
                ),
                TextFormField(
                  obscureText: true,
                  decoration: InputDecoration(labelText: "密码", hintText: "请输入密码！", icon: Icon(Icons.lock)),
                  validator: (v){
                    return v.trim().length>0?null:"密码不能为空！";
                  },
                  onChanged: (v){
                    setState(() {
                      _password = v;
                    });
                  },
                ),
                SizedBox(height: 20,),
                Container(
                  padding: EdgeInsets.only(left: 38.0),
                  width: double.infinity,
                  child: RaisedButton(onPressed: (){
                    if( _formKey.currentState.validate() ){
                      this.goLogin();
                    }
                  }, child: Text("登录", style: TextStyle(color: Colors.white),), color: Theme.of(context).primaryColor,),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}