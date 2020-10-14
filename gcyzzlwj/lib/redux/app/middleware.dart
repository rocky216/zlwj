

import 'package:gcyzzlwj/redux/app/action.dart';
import 'package:gcyzzlwj/utils/http.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';

import '../state.dart';

ThunkAction<IndexState> getHomeInfo(context, {params, next}){
  return (Store<IndexState> store) async {
    try{
      var data = await NetHttp.request("/api/app/owner/common/indexInfo", context, params: {});
      
      if(data != null){
        store.dispatch( HomeAction(data) );
      }

    }catch(e){
      print(e);
    }
  };
}

ThunkAction<IndexState> getDrawerInfo(context, {params, next}){
  return (Store<IndexState> store) async {
    try{
      var data = await NetHttp.request("/api/app/owner/common/getHeList", context, params: {});
      
      if(data != null){
        store.dispatch( HeLisyAction(data) );
      }

    }catch(e){
      print(e);
    }
  };
}

ThunkAction<IndexState> getUserRela(context, {params, next}){
  return (Store<IndexState> store) async {
    try{
      var data = await NetHttp.request("/api/app/owner/my/myInfo", context, params: {});
      
      if(data != null){
        store.dispatch( UserRaleAction(data) );
      }

    }catch(e){
      print(e);
    }
  };
}

ThunkAction<IndexState> getUsers(context, {params, next}){
  return (Store<IndexState> store) async {
    try{
      var data = await NetHttp.request("/api/app/owner/user/userInfo", context, params: {});
      
      if(data != null){
        store.dispatch( UsersAction(data) );
      }

    }catch(e){
      print(e);
    }
  };
}