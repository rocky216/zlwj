import 'package:flutter/material.dart';
import 'package:fluwx/fluwx.dart' as fluwx;
import 'package:gcyzzlwj/utils/http.dart';
import 'package:gcyzzlwj/utils/index.dart';

class MyPay extends StatefulWidget {
  final Widget child;
  final Map<String, dynamic> params;
  final Function next;
  final bool disabled;
  MyPay({Key key, @required this.child, @required this.params, this.next, this.disabled=false}) : super(key: key);

  @override
  _MyPayState createState() => _MyPayState();
}

class _MyPayState extends State<MyPay> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    this._initFluwx();
    fluwx.weChatResponseEventHandler.listen((res) {
      // print(res.errStr);
      // print(res.errCode);
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
        );
    var result = await fluwx.isWeChatInstalled;
    // print("微信注册成功-- $result");
  }

  paywx() async {
    try{
      var data = await NetHttp.request("/api/app/owner/order/power/unifiedOrder", context, params: widget.params);
    if(data != null){
      if(widget.next!=null){
        widget.next();
      }
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

  @override
  Widget build(BuildContext context) {
    return Container(
       child: GestureDetector(
         onTap: (){
           if(widget.disabled){
             return;
           }
           if(widget.params["payment"] == null || widget.params["payment"].toString() == "0" ){
             showToast("请选择金额");
             return;
           }
           this.paywx();
         },
         child: widget.child,
       ),
    );
  }
}