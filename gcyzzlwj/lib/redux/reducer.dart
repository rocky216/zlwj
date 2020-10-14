import 'package:gcyzzlwj/redux/app/reducer.dart';
import 'package:gcyzzlwj/redux/other/reducer.dart';
import 'package:gcyzzlwj/redux/state.dart';



IndexState reducer(IndexState state, action){
  return IndexState(
    appReducer(state.app, action),
    otherReducer(state.other, action)
  );
}