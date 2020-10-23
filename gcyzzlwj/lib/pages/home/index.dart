import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:gcyzzlwj/components/MyHeader.dart';
import 'package:gcyzzlwj/components/MyScrollView.dart';
import 'package:gcyzzlwj/pages/home/HomeDrawer.dart';
import 'package:gcyzzlwj/pages/home/HomeProperty.dart';
import 'package:gcyzzlwj/pages/home/HomeSwiper.dart';
import 'package:gcyzzlwj/redux/export.dart';


class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  
  @override
  _HomePageState createState(){
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage>  {



List serviceList = [
    {"name": "访客", "img": "assets/images/visitor.png", "link": "/visitor"},
    {"name": "门禁", "img": "assets/images/control.png", "link": "/control"},
    {"name": "充电桩", "img": "assets/images/pile.png", "link": "/pile"},
    {"name": "车牌", "img": "assets/images/plate.png", "link": "/plate"},
  ];
  
  

  @override
  void initState() { 
    super.initState();
    
  }

  


  @override
  Widget build(BuildContext context) {
    return Container(
        child: StoreConnector<IndexState, Map>(
          onInit: (Store store){
            if(store.state.app.home == null){
              store.dispatch( getHomeInfo(context));
            }
            if(store.state.app.users == null){
              store.dispatch( getUsers(context) );
            }
            
          },
          converter: (store)=>store.state.app.home,
          builder: (BuildContext context, state){
            return state==null?Container()
            : Scaffold(
              appBar: MyHeader(theme: "blue", title: state["heName"],
              leading: Builder(
                builder: (context){
                  return FlatButton(
                    child: Icon(Icons.dehaze, color: Colors.white,),
                    onPressed: (){
                      Scaffold.of(context).openDrawer();
                    },
                  );
                },
              ),),
              body: MyScrollView(
                child: Column(
                  children: [
                    Container(
                      width: double.infinity,
                      color: Colors.blue,
                      padding: EdgeInsets.only(bottom: 5.0),
                      child: HomeSwiper(banners: state["banner"],),
                    ),
                    HomeProperty(),
                    Container(
                      margin: EdgeInsets.only(top: 10.0),
                      child: Wrap(
                        children: serviceList.asMap().keys.map((f) => 
                          Container(
                          padding: EdgeInsets.fromLTRB(f%2==1?5.0:10.0, 5.0, f%2==1?10.0:5.0, 5.0),
                          width: MediaQuery.of(context).size.width/2,
                          child: GestureDetector(
                              child: Image(image: AssetImage(serviceList[f]["img"]), fit: BoxFit.fitHeight),
                              onTap: (){
                                Navigator.of(context).pushNamed(serviceList[f]["link"]);
                              }),
                        ),
                        ).toList(),
                      ),
                    )
                  ],
                ),
              ),
              drawer: Container(
                width: 200.0,
                child: Drawer(
                  child: HomeDrawer(),
                ),
              )
            );
          }, 
        ),
    );
  }
}