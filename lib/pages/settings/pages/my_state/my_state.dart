class MyState{
  String? _date;
  String? _dayName;
  int? _secondsElapsed;
  String? _dateString;

  String? get date => _date;

  String? get dayName => _dayName;

  int? get secondsElapsed => _secondsElapsed;

  String? get dateString => _dateString;

  MyState({required date, required dayName, required seconds,required dateString}){
    _date = date;
    _dayName = dayName;
    _secondsElapsed = seconds;
    _dateString = dateString;
  }

  MyState.fromJson(Map<String,dynamic> json){
    _date = json['date'];
    _dayName = json['dayName'];
    _secondsElapsed = json['secondsElapsed'];
    _dateString = json['dateString'];
  }

  Map<String,dynamic> toJson() {
    return {
      "date":_date,
      "dayName":_dayName,
      "secondsElapsed":_secondsElapsed,
      "dateString":_dateString
    };
  }


}