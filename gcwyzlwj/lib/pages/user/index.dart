import 'package:flutter/material.dart';
import 'package:gcwyzlwj/components/MyHeader.dart';
import 'package:gcwyzlwj/components/MyInput.dart';
import 'package:gcwyzlwj/components/MyScrollView.dart';
import 'package:gcwyzlwj/redux/export.dart';

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
        title: Container(
          margin: EdgeInsets.only(left: 10.0),
          child: Text("个人中心"),
        ),
        actions: MaterialButton(
          onPressed: (){

          },
          child: Text("退出", ),
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
                  )
                ],
              ),
            );
          }),
      ),
    );
  }
}