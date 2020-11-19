import 'package:flutter/material.dart';
import 'package:gcyzzlwj/redux/export.dart';
import 'package:gcyzzlwj/redux/state.dart';
import 'package:gcyzzlwj/utils/http.dart';

class HomeDrawer extends StatefulWidget {
  var callback;
  HomeDrawer({Key key, this.callback}) : super(key: key);

  @override
  _HomeDrawerState createState() => _HomeDrawerState();
}

class _HomeDrawerState extends State<HomeDrawer> {
  
  @override
  void initState() { 
    super.initState();
  }

  switchHe(id) async {
    var data = await NetHttp.request("/api/app/owner/user/cutHe", context, method: "post", params: {
      "nowHeId": id.toString()
    });
    if(data != null){
      StoreProvider.of<IndexState>(context).dispatch(getHomeInfo(context));
      Navigator.of(context).pop();
    }
  }


// /api/app/owner/user/info/
  @override
  Widget build(BuildContext context) {
    return StoreConnector<IndexState, AppState>(
      onInit: (store){
        if(store.state.app.helist == null){
          store.dispatch( getDrawerInfo(context) );
        }
        
      },
      converter: (store)=>store.state.app,
      builder: (context, state){
        
        return Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                width: double.infinity,
                padding: EdgeInsets.fromLTRB(20.0, 80.0, 20.0, 30.0),
                decoration: BoxDecoration(color: Theme.of(context).primaryColor),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                      CircleAvatar(
                        backgroundColor: Color(0xFFeeeeee),
                        backgroundImage: state.users["avatarUrl"]!=null?NetworkImage(state.users["avatarUrl"]):null,
                        child: state.users["avatarUrl"]!=null?Container():Icon(Icons.person, color: Colors.grey,),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(15.0, 5.0, 0, 0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(state.users["userName"]??"", style: TextStyle(color: Colors.white),),
                            Text(state.users["account"], style: TextStyle(color: Colors.white),)
                          ]),
                    )
                  ],
                )
              ),
              state.helist==null?Container()
              :Column(
                children: state.helist.map((f) => 
                  ListTile(
                    title: Text(f["name"]),
                    onTap: () {
                      this.switchHe(f["id"]);
                    },
                  )
                ).toList(),
              )
            ],
          ),
          
        );
      },
    );
  }
}