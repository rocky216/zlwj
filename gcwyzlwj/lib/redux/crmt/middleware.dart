import 'package:flutter/cupertino.dart';
import 'package:gcwyzlwj/redux/crmt/action.dart';
import 'package:gcwyzlwj/redux/export.dart';
import 'package:gcwyzlwj/utils/http.dart';
import 'package:redux_thunk/redux_thunk.dart';

ThunkAction<IndexState> getFeeOrder(context, {@required params, next}){
  return (Store<IndexState> store) async {
    try{
      var data = await NetHttp.request("/api/app/property/propertyOrder/listPage", context, params: params);
      store.dispatch(CrmtFeeAction(data));
    }catch(e){
      print(e);
    }
  };
}

ThunkAction<IndexState> getExpendOrder(context, {@required params, next}){
  return (Store<IndexState> store) async {
    try{  
      var data = await NetHttp.request("/api/app/property/otherPay/listPage", context, params: params);
      store.dispatch(CrmtExpendAction(data));
    }catch(e){
      print(e);
    }
  };
}

ThunkAction<IndexState> getIncomeOrder(context, {@required params, next}){
  return (Store<IndexState> store) async {
    try{  
      var data = await NetHttp.request("/api/app/property/other/listPage", context, params: params);
      store.dispatch(CrmtIncomeAction(data));
    }catch(e){
      print(e);
    }
  };
}

ThunkAction<IndexState> getExamerrOrder(context, {@required params, next}){
  return (Store<IndexState> store) async {
    try{  
      var map = store.state.crmt.examerr; 
      var data = await NetHttp.request("/api/app/property/propertyOrder/reviewed", context, params: params);
      if(map == null || params["current"]==1 ){
        store.dispatch(CrmtExamerrAction(data));
      }else{
        data["list"].insertAll(0,map["list"]);
        store.dispatch(CrmtExamerrAction(data));
      }
    }catch(e){
      print(e);
    }
  };
}
ThunkAction<IndexState> getExamerrData(item, {bool clear=false}){
  return (Store<IndexState> store) async {
    Map map = store.state.crmt.examerr;
    if(!clear && map !=null && map["list"].isNotEmpty){
      var newList = map["list"].where((o)=>o["id"] != item["id"]).toList();
      map["list"] = newList;
      map["total"] = map["total"]-1;
      store.dispatch(CrmtExamerrAction(map));
    }
    if(clear){
      store.dispatch(CrmtExamerrAction(null));
    }
  };
}

ThunkAction<IndexState> getExamexpendOrder(context, {@required params, next}){
  return (Store<IndexState> store) async {
    try{  
      var map = store.state.crmt.examexpend;
      var data = await NetHttp.request("/api/app/property/otherPay/reviewed", context, params: params);
      if(map == null || params["current"]==1 ){
        store.dispatch(CrmtExamexpendAction(data));
      }else{
        data["list"].insertAll(0,map["list"]);
        store.dispatch(CrmtExamexpendAction(data));
      }
      
    }catch(e){
      print(e);
    }
  };
}

ThunkAction<IndexState> getExamexpendData(item, {bool clear=false}){
  return (Store<IndexState> store) async {
    Map map = store.state.crmt.examexpend;
    if(!clear && map !=null && map["list"].isNotEmpty){
      var newList = map["list"].where((o)=>o["id"] != item["id"]).toList();
      
      map["list"] = newList;
      map["total"] = map["total"]-1;
      store.dispatch(CrmtExamexpendAction(map));
    }
    if(clear){
      store.dispatch(CrmtExamexpendAction(null));
    }
  };
}

ThunkAction<IndexState> getExamincomeOrder(context, {@required params, next}){
  return (Store<IndexState> store) async {
    try{  
      var map = store.state.crmt.examincome;
      var data = await NetHttp.request("/api/app/property/other/reviewed", context, params: params);
      if(map == null || params["current"]==1){
        store.dispatch(CrmtExamincomeAction(data));
      }else{
        data["list"].insertAll(0,map["list"]);
        store.dispatch(CrmtExamincomeAction(data));
      }
    }catch(e){
      print(e);
    }
  };
}

ThunkAction<IndexState> getExamincomeData(item, {bool clear=false}){
  return (Store<IndexState> store) async {
    Map map = store.state.crmt.examincome;
    if(!clear && map !=null && map["list"].isNotEmpty){
      var newList = map["list"].where((o)=>o["id"] != item["id"]).toList();
      
      map["list"] = newList;
      map["total"] = map["total"]-1;
      store.dispatch(CrmtExamincomeAction(map));
    }
    if(clear){
      store.dispatch(CrmtExamincomeAction(null));
    }
  };
}