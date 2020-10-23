import 'package:flutter/material.dart';
import 'package:gcyzzlwj/components/MyHeader.dart';
import 'package:gcyzzlwj/components/MyList.dart';

class HallPage extends StatefulWidget {
  HallPage({Key key}) : super(key: key);

  @override
  _HallPageState createState() => _HallPageState();
}

class _HallPageState extends State<HallPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyHeader(title: "议事堂",),
      body: MyList(
        url: "/api/app/owner/theme/blobs/",
        itemBuilder: (dataList, index){
          List imgs = dataList[index]["contentUrl"];
          return MaterialButton(
            padding: EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 5.0),
            child: Container(
              padding: EdgeInsets.fromLTRB(5.0, 5.0, 5.0, 5.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(bottom: 5.0),
                    child: Text(dataList[index]["themeName"], style: TextStyle(fontWeight: FontWeight.w700)),
                  ),
                  Row(
                    children: imgs.map((f)=>(
                      Expanded(
                        child: Image.network(f, height: 100.0, fit: BoxFit.fill)
                      )
                    )).toList(),
                  ),
                  Text(dataList[index]["themeEndText"], maxLines: 2, overflow: TextOverflow.ellipsis, style: TextStyle(color: Color(0xFF666666)), ),
                  Container(
                    margin: EdgeInsets.only(top: 5.0),
                    child: Text('发布时间：'+dataList[index]["buildTime"], textAlign: TextAlign.right,
                          style: TextStyle(color: Color(0xFF666666)),),
                  )
                ],
              ),
            ),
            onPressed: (){
              Navigator.of(context).pushNamed("/hall/detial", arguments: dataList[index]);
            },
          );
        },
      ),
    );
  }
}