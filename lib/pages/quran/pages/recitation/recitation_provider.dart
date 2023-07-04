import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:nour_al_quran/shared/database/quran_db.dart';
import 'package:nour_al_quran/shared/entities/reciters.dart';
import 'package:nour_al_quran/shared/entities/surah.dart';

class RecitationProvider extends ChangeNotifier{
  List<Reciters> _recitersList = [];
  List<Reciters> get recitersList => _recitersList;
  List<Surah> _surahNamesList = [];
  List<Surah> get surahNamesList => _surahNamesList;
  List<Reciters> _favReciters = [];
  List<Reciters> get favReciters => _favReciters;


  Future<void> getFavReciter() async {
    _favReciters = await QuranDatabase().getFavReciters();
    notifyListeners();
  }

  Future<void> getSurahName() async {
    _surahNamesList = await QuranDatabase().getSurahName();
    notifyListeners();
  }


  Future<void> getReciters() async {
    _recitersList = await QuranDatabase().getReciter();
    notifyListeners();
  }

  // both method are used to change state only
  void addFav(int reciterId){
    addFavInLocal(reciterId);
    int index = _recitersList.indexWhere((element) => element.reciterId == reciterId);
    _recitersList[index].setIsFav = 1;
    notifyListeners();
  }

  void removeFavReciter(int reciterId){
    removeFavFromLocal(reciterId);
    _favReciters.removeWhere((element) => element.reciterId == reciterId);
    notifyListeners();
    int index = _recitersList.indexWhere((element) => element.reciterId == reciterId);
    _recitersList[index].setIsFav = 0;
    notifyListeners();
  }

  void addFavInLocal(int reciterId){
    List favReciterList = Hive.box("myBox").get("favReciters") ?? <int>[];
    favReciterList.add(reciterId);
    Hive.box('myBox').put("favReciters", favReciterList);
    QuranDatabase().updateReciterIsFav(reciterId,1);
  }

  void removeFavFromLocal(int reciterId){
    List favReciterList = Hive.box("myBox").get("favReciters") ?? <int>[];
    if(favReciterList.isNotEmpty){
      favReciterList.removeWhere((element) => element == reciterId);
      Hive.box("myBox").put("favReciters", favReciterList);
      QuranDatabase().updateReciterIsFav(reciterId,0);
    }
  }

}