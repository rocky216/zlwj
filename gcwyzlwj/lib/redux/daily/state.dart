class DailyState {
  List record;
  Map inspect;

  DailyState({this.record, this.inspect});

  factory DailyState.initial(){
    return DailyState();
  }
}