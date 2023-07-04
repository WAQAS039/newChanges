import 'dart:convert';

class Reciters{
  int? _reciterId;
  String? _reciterName;
  List? _recitationCount;
  List<int>? _downloadSurahList;
  String? _imageUrl;
  String? _audioUrl;
  int? _isFav;


  int? get reciterId => _reciterId;
  String? get reciterName => _reciterName;
  List? get recitationCount => _recitationCount;
  List<int>? get downloadSurahList => _downloadSurahList;
  String? get imageUrl => _imageUrl;
  String? get audioUrl => _audioUrl;
  int? get isFav => _isFav;

  set setDownloadSurahList(List<int> value) {
    _downloadSurahList = value;
  }


  set setIsFav(int value) => _isFav = value;

  Reciters({
    required reciterId,
    required reciterName,
    required recitationCount,
    required downloadSurahList,
    required imageUrl,
    required audioUrl,required isFav}){
    _reciterId = reciterId;
    _reciterName = reciterName;
    _recitationCount = recitationCount;
    _downloadSurahList = downloadSurahList;
    _imageUrl = imageUrl;
    _audioUrl = audioUrl;
    _isFav = isFav;
  }

  Reciters.fromJson(Map<String,dynamic> json){
    _reciterId = json['reciter_id'];
    _reciterName = json['reciter_name'];
    _recitationCount = jsonDecode(json['recitation_count']);
    _downloadSurahList = jsonDecode(json['download_surah_list']).cast<int>();
    _imageUrl = json['image_url'];
    _audioUrl = json['audio_url'];
    _isFav = json['is_fav'];
  }

  Map<String,dynamic> toJson(){
    return {
      "reciter_id":_reciterId,
      "reciter_name":_reciterName,
      "recitation_count":_recitationCount.toString(),
      "download_surah_list":_downloadSurahList.toString(),
      "image_url":_imageUrl,
      "audio_url":_audioUrl,
      "is_fav":_isFav
    };
  }
}