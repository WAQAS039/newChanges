import 'dart:io';

import 'package:flutter/material.dart';
import 'package:nour_al_quran/shared/database/quran_db.dart';
import 'package:nour_al_quran/shared/entities/reciters.dart';
import 'package:nour_al_quran/shared/entities/surah.dart';
import 'package:nour_al_quran/shared/routes/routes_helper.dart';
import 'package:path_provider/path_provider.dart';

class DownloadManagerProvider extends ChangeNotifier{
  List<Reciters> _recitersList = [];
  List<Reciters> _whichHaveDownloaded = [];
  List<Reciters> get whichHaveDownloaded => _whichHaveDownloaded;
  Reciters? _recitersName;
  Reciters? get recitersName => _recitersName;
  List<Surah> _downloadSurahs = [];
  List<Surah> get downloadSurahs => _downloadSurahs;

  Future<void> getReciters() async {
    _recitersList = await QuranDatabase().getReciter();
    notifyListeners();
    // List<String> reciters = await getAvailableReciters();
    if(_recitersList.isNotEmpty){
      for(var models in _recitersList){
        // int index = reciters.indexWhere((element) => element == models.reciterName);
        // if(index != -1){
        //   if(models.reciterName == reciters[index]){
        //     _whichHaveDownloaded.add(models);
        //     notifyListeners();
        //   }
        // }
        if(models.downloadSurahList!.isNotEmpty){
          _whichHaveDownloaded.add(models);
          notifyListeners();
        }
      }
    }
  }

  /// get reciters names those have any downloaded surahs available in local
  getAvailableReciters() async {
    var directory = await getApplicationDocumentsDirectory();
    final audioFilesPath = '${directory.path}/recitation';
    if (Directory(audioFilesPath).existsSync()) {
      final audioDir = Directory(audioFilesPath);
      final recitersNames = audioDir.listSync()
          .map((dir) => dir.path.split('/').last)
          .toList();
      return recitersNames;
    }
  }


  void goToDownloadAudios(int index,BuildContext context){
    _recitersName = _whichHaveDownloaded[index];
    getDownloadSurah(_whichHaveDownloaded[index].downloadSurahList!);
    notifyListeners();
    Navigator.of(context).pushNamed(RouteHelper.downloadedSurahManager);
  }

  void resetReciters(){
    _whichHaveDownloaded = [];
    notifyListeners();
  }

  Future<void> getDownloadSurah(List surahs) async {
    _downloadSurahs = [];
    for(var values in surahs){
      var surah = await QuranDatabase().getSpecificSurahName(values);
      if(!_downloadSurahs.contains(surah)){
        _downloadSurahs.add(surah!);
        notifyListeners();
      }
    }
  }

  Future<void> deleteDownloadedSurah(String surahID,int index,Reciters reciters) async {
    print(reciters.downloadSurahList!);
    String surahId = surahID.length == 1 ? "00$surahID" : surahID.length == 2 ? "0$surahID":surahID;
    var directory = await getApplicationDocumentsDirectory();
    var path = "${directory.path}/recitation/${_recitersName!.reciterName}/fullRecitations/$surahId.mp3";
    File(path.toString()).deleteSync();
    _downloadSurahs.removeAt(index);
    notifyListeners();
    reciters.downloadSurahList!.removeWhere((element) => element.toString() == surahID);
    if(reciters.downloadSurahList!.isEmpty){
      _whichHaveDownloaded.removeWhere((element) => element.reciterId == reciters.reciterId);
    }
    notifyListeners();
    print(reciters.downloadSurahList!);
    QuranDatabase().updateReciterDownloadList(reciters.reciterId!, reciters);
  }
}