import 'package:flutter/material.dart';
import 'package:gcwyzlwj/components/MyHeader.dart';
import 'package:gcwyzlwj/components/MyScrollView.dart';
import 'package:gcwyzlwj/pages/home/Crmt.dart';
import 'package:gcwyzlwj/pages/home/Daily.dart';
import 'package:gcwyzlwj/pages/home/DrawerPart.dart';
import 'package:gcwyzlwj/pages/home/Repair.dart';
import 'package:gcwyzlwj/redux/export.dart';
import 'package:gcwyzlwj/utils/index.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Map currentHe;

  @override
  void initState() { 
    super.initState();
    this.getCurrentHe();
  }

  

  getCurrentHe() async {
    Map<String, dynamic> map = await getUserInfo();
    if(map != null){
      setState(() {
        this.currentHe = map["nowHe"];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyHeader(
        goback: false,
        title: currentHe!=null?Text(currentHe["name"]):Container(),
        leading: Builder(builder: (BuildContext context){
          return Container(
            width: 60.0,
            child: FlatButton(onPressed: (){
              Scaffold.of(context).openDrawer();
            }, child: Icon(Icons.dehaze)),
          );
        }),
      ),
      drawer: DrawerPart(next: (){
        getCurrentHe();
      }),
      body: MyScrollView(
        child: StoreConnector<IndexState, IndexState>( 
          converter: (store)=>store.state, 
          builder: (context, state){
            return Column(
              children: <Widget>[
                HomeDaily(),
                Repair(),
                HomeCrmt(),
              ],
            );
          },
        ),
      ),
    );
  }
}