import 'package:flutter/material.dart';
import 'package:gcwyzlwj/components/MyHeader.dart';
import 'package:gcwyzlwj/components/MyScrollView.dart';
import 'package:gcwyzlwj/redux/export.dart';
import 'package:gcwyzlwj/utils/index.dart';

class UserPage extends StatefulWidget {
  UserPage({Key key}) : super(key: key);

  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyHeader(
        goback: false,
        title: Container(
          margin: EdgeInsets.only(left: 10.0),
          child: Text("个人中心"),
        ),
        actions: MaterialButton(
          onPressed: (){
            popconfirm(context, title: Text("是否退出登录？", style: TextStyle(fontSize: 16.0),), next: () async {
              StoreProvider.of<IndexState>(context).dispatch( ClearIndexAction() );
              await removeUserInfo();
              Navigator.of(context).pushNamedAndRemoveUntil("/login", (route)=>false);
            });
          },
          child: Text("退出登录", ),
        ),
      ),
      body: MyScrollView(
        child: StoreConnector<IndexState, Map>(
          onInit: (Store store){
            if(store.state.app.user==null){
              store.dispatch( getUsers(context, params: {}) );
            }
            
          },
          converter: (Store store)=>store.state.app.user,
          builder: (BuildContext context, state){
            
            return Container(
              child: Column(
                children: <Widget>[
                  Card(
                    child: GestureDetector(
                      onTap: (){
                        Navigator.of(context).pushNamed("/user/userinfo");
                      },
                      child: Container(
                        padding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 20.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                CircleAvatar(
                                  child: Icon(Icons.person, color: state!=null && state["userHeadUrl"].isNotEmpty?Color(0x0cdddddd):Colors.grey,),
                                  backgroundColor: Color(0xFFeeeeee),
                                  backgroundImage: state!=null && state["userHeadUrl"].isNotEmpty?NetworkImage(state["userHeadUrl"]):null,
                                ),
                                Container(
                                  margin: EdgeInsets.only(left: 10.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(state==null?"":"${state['name']}", style: TextStyle(fontSize: 18.0),),
                                      Text(state==null?"":"${state['phone']}", style: TextStyle(color: Color(0xFF666666)),)
                                    ],
                                  ),
                                )
                              ],
                            ),
                            Icon(Icons.chevron_right, size: 36.0, color: Color(0xFF999999),)
                          ],
                        ),
                      ),
                    ),
                  ),
                  Card(
                    child: Column(
                      children: <Widget>[
                        ListTile(
                          onTap: (){
                            Navigator.of(context).pushNamed("/user/setpassword");
                          },
                          leading: Icon(Icons.lock, color: Color(0xFF777777), size: 20.0,),
                          title: Text("设置密码", style: TextStyle(fontSize: 14.0),),
                          trailing: Icon(Icons.chevron_right),
                        ),
                        ListTile(
                          onTap: (){
                            Navigator.of(context).pushNamed("/agreement");
                          },
                          leading: const Icon(IconData(0xe67e, fontFamily: 'AntdIcons'), color: Color(0xFF777777), size: 20.0,),
                          title: Text("用户隐私协议", style: TextStyle(fontSize: 14.0),),
                          trailing: Icon(Icons.chevron_right),
                        )
                      ],
                    ),
                  )
                ],
              ),
            );
          }),
      ),
    );
  }
}