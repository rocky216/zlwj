import 'package:gcyzzlwj/redux/app/action.dart';
import 'package:gcyzzlwj/redux/app/state.dart';



AppState appReducer(AppState state, action){
  if(action is HomeAction){
    return AppState(home: action.home, helist: state.helist, userale: state.userale, users: state.users);
  }
  if(action is HeLisyAction){
    return AppState( helist: action.helist, home: state.home, userale: state.userale, users: state.users);
  }
  if(action is UserRaleAction){
    return AppState(userale: action.userale, home: state.home, helist: state.helist, users: state.users);
  }
  if(action is UsersAction){
    return AppState(users: action.users, home: state.home, helist: state.helist, userale: state.userale);
  }
  if( action is ClearAction ){
    return AppState();
  }
  return state;
}