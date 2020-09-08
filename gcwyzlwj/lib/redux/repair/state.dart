class RepairState {
  Map person;
  Map torepair;

  RepairState({this.person, this.torepair});

  factory RepairState.initial(){
    return RepairState();
  }
}