import 'package:flutter/material.dart';
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
    {"title": "房产", "link": "/","icon": const Icon(IconData(0xe630,fontFamily: 'AntdIcons'), size: 26.0, color: Colors.black54,) },
    {"title": "一卡通", "link": "/","icon": const Icon(IconData(0xe60c,fontFamily: 'AntdIcons'), size: 26.0, color: Colors.black54,)},
    {"title": "人脸", "link": "/","icon": const Icon(IconData(0xe60a,fontFamily: 'AntdIcons'), size: 26.0, color: Colors.black54,)},
    {"title": "车辆", "link": "/","icon": const Icon(IconData(0xe71a,fontFamily: 'AntdIcons'), size: 28.0, color: Colors.black54,)},
    {"title": "成员", "link": "/","icon": const Icon(IconData(0xe6cf,fontFamily: 'AntdIcons'), size: 26.0, color: Colors.black54,)},
  ];

  List behaviorList = [
    {"title": "缴费记录","link":"/", "icon": const Icon(IconData(0xe625,fontFamily: 'AntdIcons'), size: 22.0, color: Colors.black54,), "show": 0},
    {"title": "投票记录","link":"/", "icon": const Icon(IconData(0xe61f,fontFamily: 'AntdIcons'), size: 22.0, color: Colors.black54,)},
    {"title": "充电订单","link":"/", "icon": const Icon(IconData(0xe62c,fontFamily: 'AntdIcons'), size: 22.0, color: Colors.black54,)},
    {"title": "停车订单","link":"/", "icon": const Icon(IconData(0xe64b,fontFamily: 'AntdIcons'), size: 24.0, color: Colors.black54,)},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyHeader(
        title: "个人中心",
        actions: FlatButton(
          onPressed: () {
            removeUserInfo();
            Navigator.of(context).pushNamedAndRemoveUntil("/login", (route) => false);
          },
          child: Text("退出"),
        ),
      ),
      body: MyScrollView(
        child: StoreConnector<IndexState, AppState>(
          onInit: (store){
            if(store.state.app.userale==null){
              store.dispatch( getUserRela(context) );
            }
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

                    },
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 10.0, right: 10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: this.assetsList.map((f){
                      
                      return GestureDetector(
                        onTap: (){
                          
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