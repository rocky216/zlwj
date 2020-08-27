class CrmtState {
  Map fee;
  Map expend;
  Map income;
  Map examerr;
  CrmtState({this.fee, this.expend, this.income, this.examerr});

  factory CrmtState.initial(){
    return CrmtState();
  }
}