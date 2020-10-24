import 'package:flutter/material.dart';
import 'package:gcwyzlwj/utils/index.dart';

class MyUploadImg extends StatefulWidget {
  final Widget child;
  final Function next;
  MyUploadImg({Key key, this.child, this.next}) : super(key: key);

  @override
  _MyUploadImgState createState() => _MyUploadImgState();
}

class _MyUploadImgState extends State<MyUploadImg> {
  @override
  Widget build(BuildContext context) {
    return Container(
       child: GestureDetector(
         child: widget.child,
         onTap: (){
          showDialog(
            context: context,
            child: Center(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8.0)
                ),
                padding: EdgeInsets.all(15.0),
                
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    MaterialButton(
                      color: Colors.white,
                      elevation: 0,
                      onPressed: () async {
                        Navigator.of(context).pop();
                        var url = await uploadImg("camera");
                        if(url != null && widget.next != null){
                          widget.next(url);
                        }
                      },
                      child: Text("选择相机"),
                    ),
                    MaterialButton(
                      color: Colors.white,
                      elevation: 0,
                      onPressed: () async {
                        Navigator.of(context).pop();
                        var url = await uploadImg("image");
                        if(url != null && widget.next != null){
                          widget.next(url);
                        }
                      },
                      child: Text("选择相册"),
                    ),
                  ],
                ),
              ),
            )
          );
         },
       ),
    );
  }
}