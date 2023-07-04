class Salah{
  String? _name;
  String? _time;
  bool? _notify;
  DateTime? _prayerTime;

  String? get name => _name;
  String? get time => _time;

  bool? get notify => _notify;
  DateTime? get prayerTime => _prayerTime;

  set setIsNotify(bool value) {
    _notify = value;
  }

  Salah({required name,required time,required notify,required prayerTime}){
    _name = name;
    _time = time;
    _notify = notify;
    _prayerTime = prayerTime;
  }

}