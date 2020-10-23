import 'dart:async';
import 'package:flutter/material.dart';
import 'package:gcyzzlwj/components/MyScrollView.dart';
import 'package:gcyzzlwj/utils/http.dart';
import 'package:gcyzzlwj/utils/index.dart';

class RegisterPage extends StatefulWidget {
  RegisterPage({Key key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  GlobalKey _formKey= new GlobalKey<FormState>();
  String _username;
  String _password;
  String _code;
  int time=60;
  int totalTime = 60;
  var timer=null;

  countDowm(){
    const period = const Duration(seconds: 1);
    this.timer?.cancel();
    setState(() {
      this.time--;
    });
    print(this.time);
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
    print(this.timer);
  }
  @override
  void deactivate() {
    // TODO: implement deactivate
    super.deactivate();
    this.timer?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MyScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              width: 40.0,
              padding: EdgeInsets.fromLTRB(0.0, 20.0, 0, 20.0),
              child: FlatButton(
                child: Icon(Icons.close, color: Color(0xFF999999)),
                onPressed: (){
                  Navigator.of(context).pop();
                }
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 20.0),
              padding: EdgeInsets.all(10.0),
              child: Form(
                key: _formKey,
                child: Column(
                  
                  children: <Widget>[
                    Text("欢迎,注册智联万家！", style: TextStyle(color: Color(0xFF666666), fontSize: 22)),
                    SizedBox(height: 20.0),
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: "用户名",
                        hintText: "请输入用户名！",
                        icon: Icon(Icons.person),
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
                    ),
                    Row(
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
                              await NetHttp.request("/api/app/owner/sendCode", context, method: "post", params: {
                                'phone':this._username,
                                'type': 'regist'
                              });
                            },
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: 30.0),
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
                            var data = await NetHttp.request("/api/app/owner/user/", context, method: "post", params: {
                              "account": this._username,
                              "password": this._password,
                              "code": this._code,
                            });
                            if(data !=null){
                              showToast("注册成功");
                              Navigator.of(context).pop();
                            }
                            
                          }
                        },
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