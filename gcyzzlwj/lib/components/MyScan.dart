import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MyScan extends StatefulWidget {
  final Widget child;
  final Function next;
  MyScan({Key key, @required this.child, this.next}) : super(key: key);

  @override
  _MyScanState createState() => _MyScanState();
}

class _MyScanState extends State<MyScan> {

  final _flashOnController = TextEditingController(text: "开灯");
  final _flashOffController = TextEditingController(text: "关灯");
  final _cancelController = TextEditingController(text: "关闭");

  @override
  Widget build(BuildContext context) {
    return Container(
      child: GestureDetector(
        child: widget.child,
         onTap: (){
            scan();
          },
      ),
     
    );
  }

  scan() async {
    try{
      var options = ScanOptions(
        strings: {
          "cancel": _cancelController.text,
          "flash_on": _flashOnController.text,
          "flash_off": _flashOffController.text,
        },
      );
      ScanResult result = await BarcodeScanner.scan(options: options);
      
      if(widget.next != null){
        widget.next(result.rawContent);
      }

    } on PlatformException catch(e){
      print(e);
    }
    
  }

}