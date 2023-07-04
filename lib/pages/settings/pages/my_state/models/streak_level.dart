class StreakLevel{
  String? _lastOpen;
  int? _streakLevel;

  String? get lastOpen => _lastOpen;
  int? get streakLevel => _streakLevel;


  StreakLevel({required lastOpen, required streakLevel}){
    _lastOpen = lastOpen;
    _streakLevel = streakLevel;
  }

  StreakLevel.fromJson(Map<String,dynamic> json){
    _lastOpen = json['lastOpen'];
    _streakLevel = json['streakLevel'];
  }

  Map<String,dynamic> toJson() {
    return {
      "lastOpen":_lastOpen,
      "streakLevel":_streakLevel,
    };
  }


}