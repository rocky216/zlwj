import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:gcyzzlwj/components/MyHeader.dart';
import 'package:gcyzzlwj/components/MyScrollView.dart';
import 'package:gcyzzlwj/redux/export.dart';
import 'package:gcyzzlwj/utils/index.dart';

class UsersPage extends StatefulWidget {
  UsersPage({Key key}) : super(key: key);

  @override
  _UsersPageState createState() => _UsersPageState();
}

class _UsersPageState extends State<UsersPage> {

  List assetsList = [
    {"title": "房产", "link": "/user/house","icon": const Icon(IconData(0xe630,fontFamily: 'AntdIcons'), size: 26.0, color: Colors.black54,) },
    {"title": "一卡通", "link": "/user/card","icon": const Icon(IconData(0xe60c,fontFamily: 'AntdIcons'), size: 26.0, color: Colors.black54,)},
    // {"title": "人脸", "link": "/","icon": const Icon(IconData(0xe60a,fontFamily: 'AntdIcons'), size: 26.0, color: Colors.black54,)},
    {"title": "车辆", "link": "/user/plate","icon": const Icon(IconData(0xe71a,fontFamily: 'AntdIcons'), size: 28.0, color: Colors.black54,)},
    {"title": "成员", "link": "/user/family","icon": const Icon(IconData(0xe6cf,fontFamily: 'AntdIcons'), size: 26.0, color: Colors.black54,)},
  ];

  List behaviorList = [
    {"title": "缴费记录","link":"/user/payment", "icon": const Icon(IconData(0xe625,fontFamily: 'AntdIcons'), size: 22.0, color: Colors.black54,), "show": 0},
    {"title": "投票记录","link":"/hall/record", "icon": const Icon(IconData(0xe61f,fontFamily: 'AntdIcons'), size: 22.0, color: Colors.black54,)},
    {"title": "充电订单","link":"/pile/order", "icon": const Icon(IconData(0xe62c,fontFamily: 'AntdIcons'), size: 22.0, color: Colors.black54,)},
    {"title": "停车订单","link":"/plate/order", "icon": const Icon(IconData(0xe64b,fontFamily: 'AntdIcons'), size: 24.0, color: Colors.black54,)},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyHeader(
        title: "  个人中心",
        actions: FlatButton(
          onPressed: () {
            confirmDialog(context, title: Text("是否退出登录？"), ok: (){
              removeUserInfo();
              Navigator.of(context).pushNamedAndRemoveUntil("/login", (route) => false);
              StoreProvider.of<IndexState>(context).dispatch( ClearAction() );
            });
          },
          child: Text("退出"),
        ),
      ),
      body: MyScrollView(
        child: StoreConnector<IndexState, AppState>(
          onInit: (store){
            store.dispatch( getUserRela(context) );
          },
          converter: (store)=>store.state.app,
          builder: (context, state){
            return state.userale==null? Container()
              : Column(
              children: [
                Container(
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Color(0xFFeeeeee),
                      backgroundImage: state.users["avatarUrl"]!=null?NetworkImage(state.users["avatarUrl"]):null,
                      child: state.users["avatarUrl"]!=null?Container():Icon(Icons.person, color: Colors.grey,),
                    ),
                    title: Text(state.users["userName"],),
                    subtitle: Text(state.users["account"]),
                    trailing: Icon(Icons.chevron_right, size: 30.0,),
                    onTap: (){
                      Navigator.of(context).pushNamed("/editusers");
                    },
                  ),
                ),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: this.assetsList.map((f){
                      
                      return Expanded(
                        flex: 1,
                        child: MaterialButton(
                          padding: EdgeInsets.zero,
                          onPressed: (){
                            Navigator.of(context).pushNamed(f["link"]);
                          },
                          child: Container(
                            child: Column(
                              children: [
                                Container(
                                  margin: EdgeInsets.only(bottom: 5.0),
                                  child: f["icon"],
                                ),
                                Text(f["title"])
                              ],
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
                Container(
                  color: Color(0xFFeeeeee),
                  margin: EdgeInsets.only(right: 10.0, left: 10.0, top: 10.0),
                  padding: EdgeInsets.only(top: 5.0, bottom: 5.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        child: Column(
                          children: [
                            Text(state.userale["integral"].toString()),
                            Text("账户积分")
                          ],
                        ),
                      ),
                      Container(
                        child: Column(
                          children: [
                            Text(state.userale["balance"].toString()),
                            Text("账户余额")
                          ],
                        ),
                      ),
                      Container(
                        child: FlatButton(
                          child: Text("账单记录", style: TextStyle(color: Colors.blue),),
                          onPressed: (){
                            Navigator.of(context).pushNamed("/bill/record");
                          },
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 20.0),
                  child: Column(
                    children: this.behaviorList.map((f){
                      return f["show"]==0 && state.userale["houCount"]==0?Container()
                      :ListTile(
                        contentPadding: EdgeInsets.only(left: 10.0),
                        title: Transform(
                          transform: Matrix4.translationValues(-20, 0.0, 0.0),
                          child: Text(f["title"], style: TextStyle(fontSize: 14.0),),
                        ),
                        leading: f["icon"],
                        dense: true,
                        trailing: Icon(Icons.chevron_right, size: 30.0,),
                        onTap: (){
                          Navigator.of(context).pushNamed(f["link"]);
                        },
                      );
                    }).toList(),
                  ),
                )
              ],
            );
          },
        )
      ),
    );
  }
}