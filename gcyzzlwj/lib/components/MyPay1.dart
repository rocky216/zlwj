import 'package:flutter/material.dart';
import 'package:fluwx/fluwx.dart' as fluwx;
import 'package:gcyzzlwj/components/MyHeader.dart';
import 'package:gcyzzlwj/utils/http.dart';


class MyWxPay extends StatefulWidget {
  final arguments;
  MyWxPay({Key key, this.arguments}) : super(key: key);

  @override
  _MyWxPayState createState() => _MyWxPayState();
}

class _MyWxPayState extends State<MyWxPay> {
  GlobalKey<FormState> _formKey  = new GlobalKey<FormState>();
  String payment;

  
  @override
  void initState() { 
    super.initState();
    this._initFluwx();
    
    fluwx.weChatResponseEventHandler.listen((res) {
      print(res.errStr);
      print(res.errCode);
      if (res is fluwx.WeChatPaymentResponse) {
        print("成功了！------");
        print("pay :${res.isSuccessful}");
      }
    });

    
  }

  _initFluwx() async {
    await fluwx.registerWxApi(
      /* 支付APPID */
        appId: "wx7e527bffc978694d",
        // doOnAndroid: true,
        doOnIOS: false,
          // universalLink: "https://your.univerallink.com/link/"
        );
    var result = await fluwx.isWeChatInstalled;
    print("微信注册成功-- $result");
  }

 

  paywx() async {
    try{
      var data = await NetHttp.request("/api/app/owner/recharge/unifiedOrder", context, params: {
        "payment": payment.toString()
      });

    if(data != null){
      
      try{
        var d = await fluwx.payWithWeChat(
          appId: data["appid"].toString(),         //APPID
          partnerId: data["partnerid"].toString(),      //商户号
          prepayId: data["prepayid"].toString(),  //预支付ID
          packageValue: data["package"].toString(),   //扩展字符
          nonceStr: data["noncestr"].toString(),   //随机字符串
          timeStamp: int.parse(data["timestamp"]), //时间戳
          sign: data["sign"].toString(),        //签名
          // signType: data["signType"].toString()   //签名类型
        );
      }catch(err){
        print(err);
      }
      
    }

    }catch(err){
      print(err);
    }
  }

  handleSubmit(){
    if( _formKey.currentState.validate() ){
      this.paywx();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyHeader(
        title: "支付",
      ),
      body: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(20),
            child: Form(
              key: _formKey,
              child: TextFormField(
                decoration: InputDecoration(hintText: "请输入金额！"),
                validator: (val){
                  RegExp  isNum = new RegExp(r'^(([1-9][0-9]*)|(([0]\.\d{1,2}|[1-9][0-9]*\.\d{1,2})))$');
                  if( !isNum.hasMatch(val) ){
                    return "请输入数字";
                  }
                  return null;
                },
                onChanged: (val){
                  setState(() {
                    payment = val;
                  });
                },
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.all(20),
            width: double.infinity,
            child: RaisedButton(
              child: Text("确认支付"),
              color: Theme.of(context).primaryColor,
              textColor: Colors.white,
              onPressed: (){
                handleSubmit();
              },
            ),
          )
        ],
      ),
    );
  }
}