import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:just_audio/just_audio.dart';
import 'package:nour_al_quran/shared/database/quran_db.dart';
import 'package:nour_al_quran/shared/entities/reciters.dart';
import 'package:nour_al_quran/shared/entities/surah.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import '../../../../../settings/pages/my_state/my_state_provider_updated.dart';

class RecitationPlayerProvider with ChangeNotifier {
  Duration _duration = Duration.zero;
  Duration _position = Duration.zero;
  double? _dragValue;
  bool _isPlaying = false;
  AudioPlayer? _audioPlayer;
  bool _isOpen = false;
  bool get isOpen => _isOpen;
  int _currentIndex = 0;
  int get currentIndex => _currentIndex;
  Reciters? _reciter;
  Surah? _surah;
  List<Surah> _surahNamesList = [];
  List<Surah> get surahNamesList => _surahNamesList;
  ConcatenatingAudioSource? _playList;
  ConcatenatingAudioSource? get playList => _playList;
  bool _isLoopMode = false;
  bool get isLoopMode => _isLoopMode;

  Reciters? get reciter => _reciter;
  Surah? get surah => _surah;

  Duration get position => _position;
  double? get dragValue => _dragValue;
  bool get isPlaying => _isPlaying;
  Duration get duration => _duration;
  AudioPlayer get audioPlayer => _audioPlayer!;

  void initAudioPlayer(Reciters reciters,int current) async {
    setReciter(reciters);
    List<String> audios = await getAudioFilesFromLocal(reciters.reciterName!);
    _playList = ConcatenatingAudioSource(
      useLazyPreparation: false,
      shuffleOrder: DefaultShuffleOrder(),
      children: List.generate(audios.length, (index) => AudioSource.file(audios[index].toString())),
    );
    reciters.downloadSurahList!.sort();
    setDownloadSurahListToPlayer(reciters.downloadSurahList!);
    setCurrentIndex(current);
    if(_audioPlayer == null){
      _init(playList!);
    }else{
      _audioPlayer!.stop();
      _audioPlayer = null;
      _init(playList!);
    }
  }

  void _init(ConcatenatingAudioSource file) async{
    _audioPlayer = AudioPlayer();
    // await _audioPlayer!.setFilePath(file);
    await _audioPlayer!.setAudioSource(file,initialIndex: _currentIndex);
    _audioPlayer!.currentIndexStream.listen((currentAudio) {
      setCurrentIndex(currentAudio!);
    });
    _audioPlayer!.playerStateStream.listen((event) {
      setIsPlaying(event.playing);
      if (event.processingState == ProcessingState.completed && _currentIndex == _surahNamesList.length - 1) {
        _audioPlayer!.seek(Duration.zero);
        _audioPlayer!.pause();
      }
    });
    _audioPlayer!.durationStream.listen((duration) {
    if(duration != null){
      setDuration(duration);
    }
    });
    _audioPlayer!.positionStream.listen((position) {
    setPosition(position);
    });
  }

  Future<void> play(BuildContext context) async {
    var provider = Provider.of<MyStateProvider>(context,listen: false);
    provider.startQuranRecitationTimer("other");
    setIsPlaying(true);
    _isOpen = true;
   await _audioPlayer!.play();
  }

  void seekToNext(){
    _audioPlayer!.seekToNext();
  }
  void seekToPrevious(){
  _audioPlayer!.seekToPrevious();
  }

  void setLoopMode(bool value){
    _isLoopMode = value;
    notifyListeners();
  }


  Future<void> pause(BuildContext context) async {
    if(_audioPlayer != null){
      Provider.of<MyStateProvider>(context,listen: false).stopRecitationTimer("other");
      setIsPlaying(false);
      await _audioPlayer!.pause();
    }
  }

  void setIsPlaying(bool isPlay) async {
    _isPlaying = isPlay;
    notifyListeners();
  }

  void setDuration(Duration duration){
    _duration = duration;
    notifyListeners();
  }

  void setPosition(Duration position){
    _position = position;
    notifyListeners();
  }

  void setCurrentIndex(int index){
    _currentIndex = index;
    if(_surahNamesList.isNotEmpty){
      _surah = _surahNamesList[index];
    }
    notifyListeners();
  }
  void seek(Duration position) {
    _dragValue = position.inSeconds.toDouble();
    notifyListeners();
  }

  void closePlayer(){
    if(_isOpen){
      _isOpen = false;
      notifyListeners();
      _audioPlayer!.stop();
      _audioPlayer!.dispose();
    }
  }

  void setReciter(Reciters reciter){
    _reciter = reciter;
    notifyListeners();
  }

  Future<void> setDownloadSurahListToPlayer(List downloadList) async {
    _surahNamesList = [];
    for(int i = 0; i < downloadList.length;i++){
      var surah = await QuranDatabase().getSpecificSurahName(downloadList[i]);
      if(!_surahNamesList.contains(surah)){
        _surahNamesList.add(surah!);
        notifyListeners();
      }
    }
    print(downloadList);
  }

  // logic for verse by verse
  Future<List<String>> getAudioFilesFromLocal(String reciterName) async {
    var directory = await getApplicationDocumentsDirectory();
    final audioFilesPath = '${directory.path}/recitation/$reciterName/fullRecitations';
    final audioDir = Directory(audioFilesPath);
    final audioFiles = audioDir.listSync()
        .where((entity) => entity is File && entity.path.endsWith('.mp3'))
        .map((e) => e.path)
        .toList();
    audioFiles.sort();
    return audioFiles;
  }

  Future<void> updatePlayList(int item) async {
    var surah = await QuranDatabase().getSpecificSurahName(item);
    _surahNamesList.add(surah!);
    String surahId = surah.surahId.toString().length == 1 ? "00${surah.surahId}" : surah.surahId.toString().length == 2 ? "0${surah.surahId}":surah.surahId.toString();
    var directory = await getApplicationDocumentsDirectory();
    final audioFilesPath = '${directory.path}/recitation/${_reciter!.reciterName!}/fullRecitations/$surahId.mp3';
    _playList!.add(AudioSource.file(audioFilesPath));
    notifyListeners();
  }
}
