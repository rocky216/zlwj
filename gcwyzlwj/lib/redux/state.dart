import 'package:gcwyzlwj/redux/app/state.dart';
import 'package:gcwyzlwj/redux/crmt/state.dart';

class IndexState {
  
  AppState app;
  CrmtState crmt;

  IndexState(this.app, this.crmt);

  factory IndexState.initial(){
    return IndexState(
      AppState.initial(),
      CrmtState.initial()
    );
  }

}

