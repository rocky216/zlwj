
import 'package:gcwyzlwj/redux/reducer.dart';
import 'package:gcwyzlwj/redux/state.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart'; 

Store<IndexState> createStore(){
  return Store(
    reducers,
    initialState: IndexState.initial(),
    middleware: [
      thunkMiddleware
    ]
  );
}