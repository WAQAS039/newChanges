import 'package:flutter/material.dart';
import 'package:nour_al_quran/shared/database/quran_db.dart';
import 'package:provider/provider.dart';

import '../../../../shared/providers/dua_audio_player_provider.dart';
import 'models/dua.dart';
import 'models/dua_category.dart';

class DuaProvider extends ChangeNotifier {
  List<DuaCategory> _duaCategoryList = [];
  List<DuaCategory> get duaCategoryList => _duaCategoryList;

  List<Dua> _duaList = [];
  List<Dua> get duaList => _duaList;
  int _currentduaIndex = 0;
  int get currentDuaIndex => _currentduaIndex;

  Dua? _selectedDua;
  Dua? get selectedDua => _selectedDua;

  void printDuaList() {
    for (var dua in _duaList) {
      print('Dua ${dua.id}: ${dua.duaCategory}: ${dua.status} ');
    }
  }

  Future<void> getDuaCategories() async {
    _duaCategoryList = await QuranDatabase().getDuaCategories();
    notifyListeners();
  }

  Future<void> getDua(int duaCategoryId) async {
    //fetches all the dua in current category list
    _duaList = await QuranDatabase().getDua(duaCategoryId);
    notifyListeners();
  }

  Future<void> getAllDuas() async {
    _duaList = await QuranDatabase().getallDua();
    notifyListeners();
  }

  gotoDuaPlayerPage(
      int duaCategoryId, String duaText, BuildContext context) async {
    _duaList = [];
    _duaList = await QuranDatabase().getDua(duaCategoryId);
    if (_duaList.isNotEmpty) {
      _currentduaIndex =
          _duaList.indexWhere((element) => element.duaText == duaText);
      if (_currentduaIndex != -1) {
        _selectedDua = _duaList[_currentduaIndex];
        // ignore: use_build_context_synchronously
        Provider.of<DuaPlayerProvider>(context, listen: false)
            .initAudioPlayer(_selectedDua!.duaUrl!, context);
        notifyListeners();
      }
    }
  }

  void playNextDuaInCategory(BuildContext context) {
    _currentduaIndex = (_currentduaIndex + 1) % _duaList.length;
    _selectedDua = _duaList[_currentduaIndex];

    Provider.of<DuaPlayerProvider>(context, listen: false)
        .initAudioPlayer(_selectedDua!.duaUrl!, context);
    getNextDua();
    notifyListeners();
  }

  Map<String, dynamic> getNextDua() {
    return {
      'index': _currentduaIndex + 1,
      'dua': _duaList[_currentduaIndex],
    };
  }

  void playPreviousDuaInCategory(BuildContext context) {
    _currentduaIndex = (_currentduaIndex - 1) % _duaList.length;
    _selectedDua = _duaList[_currentduaIndex];

    Provider.of<DuaPlayerProvider>(context, listen: false)
        .initAudioPlayer(_selectedDua!.duaUrl!, context);
    getNextDua();
    notifyListeners();
  }

  void bookmark(int duaId, int value) {
    _duaList[duaId].setIsBookmark = value;
    notifyListeners();
  }
}
