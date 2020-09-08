import 'package:flutter/material.dart';
import 'package:gcwyzlwj/utils/index.dart';

class MyHeader extends StatefulWidget implements PreferredSizeWidget {
  final Widget title;
  final Widget leading;
  final Widget actions;
  final bool isHe;

  MyHeader({Key key, this.title, this.leading, this.actions, this.isHe=false}) : super(key: key);

  @override
  _MyHeaderState createState() => _MyHeaderState();

  @override
  // TODO: implement preferredSize
  Size get preferredSize => new Size.fromHeight(56.0);
}

class _MyHeaderState extends State<MyHeader> {
  String heName="";

  @override
  void initState() { 
    super.initState();
    this.getHe();
  }

  getHe() async {
    Map userInfo = await getUserInfo();
    if(userInfo != null){
      setState(() {
        heName = userInfo["nowHe"]["name"];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return new SafeArea(
      top: true,
      child: Container(
        padding: EdgeInsets.only(right: 5.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              child: Row(
                children: <Widget>[
                  Navigator.canPop(context)
                  ?Container(
                      width: 50.0,
                      child: FlatButton(
                        child: Icon(Icons.close, color: Color(0xFF666666),),
                        onPressed: (){
                          Navigator.of(context).pop();
                        },
                    ),
                  ):Padding(child: Container(),padding: EdgeInsets.only(left: 0.0),),
                  widget.leading!=null?widget.leading:Container(),
                  widget.title!=null?
                    widget.isHe?Row(children: <Widget>[Text(heName, style: TextStyle(color: Colors.blue),),widget.title],):widget.title
                  :Container(),
                ],
              )
            ),
            widget.actions!=null?widget.actions:Container(),
          ],
        ),
      ),
    );
  }
}