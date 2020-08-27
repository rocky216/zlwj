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
      var data = await NetHttp.request("/api/app/property/propertyOrder/reviewed", context, params: params);
      store.dispatch(CrmtExamerrAction(data));
    }catch(e){
      print(e);
    }
  };
}