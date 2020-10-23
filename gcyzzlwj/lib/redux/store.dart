

import 'package:gcyzzlwj/redux/reducer.dart';
import 'package:gcyzzlwj/redux/state.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';

Store<IndexState> createStore(){
  return Store(
    reducer,
    initialState: IndexState.initial(),
    middleware: [
      thunkMiddleware
    ]
  );
}