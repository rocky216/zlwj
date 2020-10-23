import 'package:flutter/material.dart';
import 'package:gcyzzlwj/components/MyBetweeItem.dart';
import 'package:gcyzzlwj/components/MyHeader.dart';
import 'package:gcyzzlwj/components/MyInput.dart';
import 'package:gcyzzlwj/components/MyScrollView.dart';
import 'package:gcyzzlwj/redux/export.dart';
import 'package:gcyzzlwj/utils/http.dart';
import 'package:gcyzzlwj/utils/index.dart';

class EditCardNamePage extends StatefulWidget {
  final arguments;

  EditCardNamePage({Key key, this.arguments}) : super(key: key);

  @override
  _EditCardNamePageState createState() => _EditCardNamePageState();
}

class _EditCardNamePageState extends State<EditCardNamePage> {
  TextEditingController controller = TextEditingController();

  @override
  void initState() { 
    super.initState();
    controller.text = widget.arguments["cardName"];
  }

  submit() async {
    var data = await NetHttp.request("/api/app/owner/my/updateCar", context,method: "post", params: {
      "carId": widget.arguments["id"].toString(),
      "cardName": this.controller.text
    });
    if(data != null){
      showToast("保存成功！");
      Navigator.of(context).pop();
      StoreProvider.of<IndexState>(context).dispatch( getCardList(context) );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyHeader(
        title: "我的一卡通",
        actions: FlatButton(
          onPressed: (){
            this.submit();
          },
          child: Text("保存", style: TextStyle(color: Colors.blue),),
        ),
      ),
      body: MyScrollView(
        child: Container(
          padding: EdgeInsets.all(10.0),
          child: Column(
            children: [
              MyBetweeItem(
                title: "卡名称：",
                value: widget.arguments["heCarStr"],
              ),
              MyBetweeItem(
                title: "IC：",
                value: widget.arguments["icNumber"],
              ),
              MyBetweeItem(
                title: "ID：",
                value: widget.arguments["idNumber"],
              ),
              MyInput(label: Text("卡标签："), controller: this.controller)
            ],
          ),
        ),
      ),
    );
  }
}