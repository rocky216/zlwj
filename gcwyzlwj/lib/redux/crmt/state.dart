class CrmtState {
  Map fee;
  Map expend;
  Map income;
  Map examerr;
  Map examexpend;
  Map examincome;
  CrmtState({this.fee, this.expend, this.income, this.examerr, this.examexpend, this.examincome});

  factory CrmtState.initial(){
    return CrmtState();
  }
}