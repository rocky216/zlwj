import 'package:flutter/material.dart';

class HomeProperty extends StatelessWidget {
  HomeProperty({Key key}) : super(key: key);

  List affair1List = [
    {"name": "小区公告", "icon": const Icon(IconData(0xe6ee,fontFamily: 'AntdIcons'), size: 16.0, color: Colors.white) , "bgcolor": 0xFF02a7f0, "link": "/notice"},
    {"name": "议事堂", "icon": const Icon(IconData(0xe621,fontFamily: 'AntdIcons'), size: 16.0, color: Colors.white) , "bgcolor": 0xFFf4c200, "link": "/hall"},
    {"name": "保洁维修", "icon": const Icon(IconData(0xe70e,fontFamily: 'AntdIcons'), size: 16.0, color: Colors.white) , "bgcolor": 0xFF3fb785, "link": "/clean"},
    {"name": "呼叫物业", "icon": const Icon(IconData(0xe70e,fontFamily: 'AntdIcons'), size: 16.0, color: Colors.white) , "bgcolor": 0xFFec6497, "link": "/call"},
  ];
  List affair2List = [
    {"name": "政务公开", "icon": const Icon(IconData(0xe621,fontFamily: 'AntdIcons'), size: 16.0, color: Colors.white), "bgcolor": 0xFFc602f0, "link": "/govern"},
    {"name": "巡查记录", "icon": const Icon(IconData(0xe607,fontFamily: 'AntdIcons'), size: 16.0, color: Colors.white), "bgcolor": 0xFFff09902, "link": "/inspect"},
    {"name": "通行记录", "icon": const Icon(IconData(0xe622,fontFamily: 'AntdIcons'), size: 16.0, color: Colors.white), "bgcolor": 0xFF6c02f0, "link": "/pass/record"},
    {"name": "报修记录", "icon": const Icon(IconData(0xe763,fontFamily: 'AntdIcons'), size: 16.0, color: Colors.white), "bgcolor": 0xFFf06102, "link": "/repair/record"},
  ];

 
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 0.0),
      width: double.infinity,
      color: Colors.blue,
      height: 180.0,
      child: Stack(
        overflow: Overflow.visible,
        children: [
          Positioned(
            width: MediaQuery.of(context).size.width-20,
            top: 0,
            left: 10,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10.0), 
                  topRight: Radius.circular(10.0),
                  bottomLeft: Radius.circular(10.0),
                  bottomRight: Radius.circular(10.0),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 15.0, //阴影模糊程度
                    spreadRadius: 1.0 //阴影扩散程度
                  ),
                ]
              ),
              padding: EdgeInsets.only(top: 20.0, bottom: 15.0),
              child: Column(
                children: [
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: affair1List.map((f){
                        return GestureDetector(
                          onTap: (){
                            Navigator.of(context).pushNamed(f["link"]);
                          },
                          child: Container(
                            height: 60.0,
                            child: Column(
                              children: [
                                CircleAvatar(
                                  radius: 20.0,
                                  backgroundColor: Color(f["bgcolor"]),
                                  child: f["icon"],
                                ),
                                Text(f["name"], style: TextStyle(fontSize: 12.0),)
                              ],
                            ),
                          ),
                        );
                      }).toList() ,
                    ),
                  ),
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: affair2List.map((f){
                        return Container(
                          margin: EdgeInsets.only(top: 20.0),
                            child: GestureDetector(
                              onTap: (){
                                Navigator.of(context).pushNamed(f["link"]);
                              },
                              child: Column(
                                children: [
                                  CircleAvatar(
                                    radius: 20.0,
                                    backgroundColor: Color(f["bgcolor"]),
                                    child: f["icon"],
                                  ),
                                  Text(f["name"], style: TextStyle(fontSize: 12.0),)
                                ],
                              ),
                            ),
                          );
                      }).toList() ,
                    ),
                  ),
                ],
              ),
            )
          )
          
        ],
      ),
    );
  }
}