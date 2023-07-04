import 'package:flutter/material.dart';

class AudioListProvider with ChangeNotifier {
  List<List<String>> _audioLists = List.generate(19, (_) => []);
  int _currentPage = 0;

  List<List<String>> get audioLists => _audioLists;
  int get currentPage => _currentPage;

  void setAudioList(int pageId, List<String> audioList) {
    _audioLists[pageId] = audioList;
    notifyListeners();
  }

  void setCurrentPage(int page) {
    _currentPage = page;
    notifyListeners();
  }
}
