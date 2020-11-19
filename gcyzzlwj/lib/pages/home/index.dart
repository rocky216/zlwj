
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:gcyzzlwj/components/MyHeader.dart';
import 'package:gcyzzlwj/pages/home/HomeClean.dart';
import 'package:gcyzzlwj/pages/home/HomeDrawer.dart';
import 'package:gcyzzlwj/pages/home/HomeProperty.dart';
import 'package:gcyzzlwj/pages/home/HomeSwiper.dart';
import 'package:gcyzzlwj/redux/export.dart';
import 'package:gcyzzlwj/utils/index.dart';


class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  
  @override
  _HomePageState createState(){
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage>  {
  

  List serviceList = [
    {"name": "访客", "img": "assets/images/visitor.png", "link": "/visitor", "isAuth": false},
    {"name": "门禁", "img": "assets/images/control.png", "link": "/control", "isAuth": false},
    {"name": "充电桩", "img": "assets/images/pile.png", "link": "/pile", "isAuth": true},
    {"name": "车牌", "img": "assets/images/plate.png", "link": "/plate", "isAuth": true},
  ];
  
  

  @override
  void initState() { 
    super.initState();
  }

  


  @override
  Widget build(BuildContext context) {
    return Container(
        child: StoreConnector<IndexState, IndexState>(
          onInit: (Store store){
            if(store.state.app.home == null){
              store.dispatch( getHomeInfo(context));
            }
            if(store.state.app.users == null){
              store.dispatch( getUsers(context) );
            }
            
            
          },
          converter: (store)=>store.state,
          builder: (BuildContext context, state){
            return state.app.home==null ?Container()
            : Scaffold(
              appBar: MyHeader(theme: "blue", title: state.app.home["heName"]??"",
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
              body: RefreshIndicator(
                onRefresh: () async {
                  StoreProvider.of<IndexState>(context).dispatch( getHomeInfo(context) );
                  return null;
                },
                child: ListView.separated(
                  itemBuilder: (context, i){
                    if(i==0){
                      return Column(
                        children: [
                          Container(
                            width: double.infinity,
                            color: Colors.blue,
                            padding: EdgeInsets.only(bottom: 5.0),
                            child: HomeSwiper(banners: state.app.home["banner"],),
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
                                      if( !serviceList[f]["isAuth"] ){
                                        isAuth((){
                                          Navigator.of(context).pushNamed(serviceList[f]["link"]);
                                        });
                                      }else{
                                        Navigator.of(context).pushNamed(serviceList[f]["link"]);
                                      }
                                      
                                    }),
                              ),
                              ).toList(),
                            ),
                          )
                        ],
                      );
                    }else{
                      return HomeClean(dataList: state.app.home["repair"], i: i-1);
                    }
                  }, 
                  separatorBuilder: (context, i){
                    if(i==0){
                      return Container(
                        padding: EdgeInsets.only(top: 10.0, bottom: 10.0, left: 10.0),
                        child: Text("报修记录"),
                      );
                    }else {
                      return Container(height: 2.0, color: Color(0xFFdddddd),);
                    }
                  }, 
                  itemCount: state.app.home["repair"].length+1),
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