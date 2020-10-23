
import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gcyzzlwj/components/MyHeader.dart';
import 'package:gcyzzlwj/utils/http.dart';
import 'package:gcyzzlwj/utils/index.dart';
import '../../components/MyScrollView.dart';


class LoginPage extends StatefulWidget {
  LoginPage({Key key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  GlobalKey _formKey= new GlobalKey<FormState>();
  String _username;
  String _password;
  String _code;
  bool isMessage=false;
  bool isCountDown=false;
  int time=60;
  int totalTime = 60;
  var timer=null;
  String rid;


  countDowm(){
    const period = const Duration(seconds: 1);
    this.timer?.cancel();
    setState(() {
      this.time--;
    });
    this.timer = Timer.periodic(period, (t) {
      setState(() {
        this.time--;
      });
      print(this.time);
      if (this.time ==0 ) {
        setState(() {
          this.time=this.totalTime;
        });
        this.timer?.cancel();
        t?.cancel();
        this.timer = null;
      }
    });
  }
  @override
  void deactivate() {
    // TODO: implement deactivate
    super.deactivate();
    this.timer?.cancel();
  }

  @override
  void initState() { 
    super.initState();
    this.getRid();
  }

  getRid(){
    initPlatformState(context, next: (rid){
      setState(() {
        this.rid=rid;
      });
    });
  }

  goLogin() async {
    var data;
    if(!this.isMessage){
      data = await NetHttp.request("/api/app/owner/user/login/password", context, method: "post", params: {
        "account": this._username,
        "password": this._password,
        "registrationId": this.rid,
        "registrationType": Platform.isIOS?"ios":"android"
      });
    }else {
      data = await NetHttp.request("/api/app/owner/user/login/code", context, method: "post", params: {
        "account": this._username,
        "code": this._code,
        "registrationId": this.rid,
        "registrationType": Platform.isIOS?"ios":"android"
      });
    }

    if(data != null){
      await setUserInfo(data);
      Navigator.of(context).pushNamedAndRemoveUntil("/index", (route) => false);
    }
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: MyHeader(
        title: "",
        actions: Container(
              padding: EdgeInsets.fromLTRB(0, 20.0, 0.0, 0),
              alignment: Alignment.bottomRight,
              child: FlatButton(
                child: Text("注册", style: TextStyle(fontSize: 16.0, color: Color(0xFF999999)),),
                onPressed: (){
                  
                },
              ),
            ),
      ),
      body: MyScrollView(
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(20.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    SizedBox(height: 30,),
                    Text("欢迎登录智联万家！", 
                    style: TextStyle(fontSize: 22, color: Color(0xFF666666)),),
                    SizedBox(height: 30,),
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: "用户名",
                        hintText: "请输入用户名！",
                        icon: Icon(Icons.person)
                      ),
                      validator: (v){
                        return v.trim().length>0?null:"用户名不能为空！";
                      },
                      onChanged: (v){
                        setState(() {
                          this._username = v;
                        });
                      },
                    ),
                    !this.isMessage?
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: "密码",
                        hintText: "请输入密码！",
                        icon: Icon(Icons.lock)
                      ),
                      obscureText: true,
                      validator: (v){
                        return v.trim().length>5?null:"密码能不能小于5位数字";
                      },
                      onChanged: (v){
                        setState(() {
                          this._password = v;
                        });
                      },
                    )
                    :Row(
                      children: <Widget>[
                        Expanded(
                          flex: 2,
                          child: TextFormField(
                            decoration: InputDecoration(
                              labelText: "验证码",
                              hintText: "请输入验证码!",
                              icon: Icon(Icons.apps)
                            ),
                            validator: (v){
                              return v.trim().length>0?null:"请输入验证码！";
                            },
                            onChanged: (v){
                              setState(() {
                                this._code = v;
                              });
                            },
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: GestureDetector(
                            child: this.time==this.totalTime?
                                Text("获取验证码", textAlign: TextAlign.center, style: TextStyle(color: Theme.of(context).primaryColor))
                                  :Text(this.time.toString()+"s后重新获取", textAlign: TextAlign.center, style: TextStyle(color: Color(0xFF999999)),),
                            onTap: () async{
                              if(this.time < this.totalTime) return;
                              if(this._username == null || this._username.isEmpty || this._username.length<11) {
                                showToast("手机号格式不正确！");
                                return;
                              }
                              this.countDowm();
                              await NetHttp.request("/api/app/owner/sendCode", context, params: {
                                'phone':this._username,
                                'type': 'login'
                              });
                            },
                          ),
                        )
                      ],
                    ),
                    
                    Container(
                      margin: EdgeInsets.fromLTRB(0, 10.0, 0, 10.0),
                      padding: EdgeInsets.only(left: 40.0),
                      child: Row(
                        children: <Widget>[
                          Text("登录即代表您已同意", style: TextStyle(color: Color(0xFF999999), fontSize: 12.0),),
                          Container(
                            width: 160.0,
                            child: GestureDetector(child: Text("《隐私权限与用户协议》", 
                                style: TextStyle(color: Theme.of(context).primaryColor, fontSize: 12.0)),
                              onTap: (){
                                Navigator.pushNamed(context, "/statement");
                              },
                            ),
                          )
                        ],
                      )
                    ),
                    SizedBox(height: 10.0),
                    Container(
                      padding: EdgeInsets.only(left: 40),
                      width: double.infinity,
                      height: 40.0,
                      child: RaisedButton(
                        child: Text("登录"),
                        color: Theme.of(context).primaryColor,
                        textColor: Colors.white,
                        onPressed: () async{
                          if((_formKey.currentState as FormState).validate()){
                            this.goLogin();
                          }
                        },
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 10.0),
                      padding: EdgeInsets.only(left: 40.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Container(
                            child: GestureDetector(
                              child: this.isMessage?Text("密码登录", style: TextStyle(color: Color(0xFF666666)))
                                    :Text("手机短信登录", style: TextStyle(color: Color(0xFF666666))),
                              onTap: (){
                                setState(() {
                                  this.isMessage = !this.isMessage;
                                });
                              },
                            ),
                          ),
                          // Text("忘记密码？", style: TextStyle(color: Color(0xFF666666)),)
                        ],
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}