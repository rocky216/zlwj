import 'package:gcyzzlwj/redux/app/state.dart';
import 'package:gcyzzlwj/redux/other/state.dart';

class IndexState {
  
  AppState app;
  OtherState other;

  IndexState(this.app, this.other); 

  factory IndexState.initial(){
    return IndexState(
      AppState.initial(),
      OtherState.initial(),
    );
  }

}