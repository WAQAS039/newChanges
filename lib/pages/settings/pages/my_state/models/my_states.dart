class MyStates{
  String? _date;
  String? _dayName;
  int? _secondsElapsed;

  String? get date => _date;

  String? get dayName => _dayName;

  int? get secondsElapsed => _secondsElapsed;


  MyStates({required date, required dayName, required seconds}){
    _date = date;
    _dayName = dayName;
    _secondsElapsed = seconds;
  }

  MyStates.fromJson(Map<String,dynamic> json){
    _date = json['date'];
    _dayName = json['dayName'];
    _secondsElapsed = json['secondsElapsed'];
  }

  Map<String,dynamic> toJson() {
    return {
      "date":_date,
      "dayName":_dayName,
      "secondsElapsed":_secondsElapsed,
    };
  }


}