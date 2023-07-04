import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:nour_al_quran/shared/entities/last_seen.dart';

class LastSeenProvider extends ChangeNotifier{
  LastSeen? _lastSeen;
  LastSeen? get lastSeen => _lastSeen;

  void getLastSeen() async{
    _lastSeen = await Hive.box('myBox').get("lastSeen");
    notifyListeners();
  }

  void saveLastSeen(LastSeen lastSeen){
    Hive.box("myBox").put("lastSeen", lastSeen).then((value) async{
      _lastSeen = await Hive.box('myBox').get("lastSeen");
      notifyListeners();
    });

  }

  void setLastSeen(LastSeen lastSeen){
    _lastSeen = lastSeen;
    notifyListeners();
  }

}