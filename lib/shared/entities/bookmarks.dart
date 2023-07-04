class Bookmarks{
  int? _surahId;
  int? _verseId;
  String? _surahName;
  String? _surahArabic;
  int? _juzId;
  String? _juzName;
  bool? _isFromJuz;
  int? _bookmarkPosition;

  int? get surahId => _surahId;
  int? get verseId => _verseId;
  String? get surahName => _surahName;
  String? get surahArabic => _surahArabic;
  int? get juzId => _juzId;
  String? get juzName => _juzName;
  bool? get isFromJuz => _isFromJuz;
  int? get bookmarkPosition => _bookmarkPosition;


  Bookmarks({required surahId,required verseId,required surahName,required surahArabic, required juzId,required juzName,required isFromJuz,required bookmarkPosition}){
    _surahId = surahId;
    _verseId = verseId;
    _surahName = surahName;
    _surahArabic = surahArabic;
    _juzId = juzId;
    _juzName = juzName;
    _isFromJuz = isFromJuz;
    _bookmarkPosition = bookmarkPosition;
  }

  Bookmarks.fromJson(Map<String,dynamic> json){
    _surahId = json['surahId'];
    _verseId = json['verseId'];
    _surahName = json['surahName'];
    _surahArabic = json['surahArabic'];
    _juzId = json['juzId'];
    _juzName = json['juzName'];
    _isFromJuz = json['isFromJuz'];
    _bookmarkPosition = json['bookmarkPosition'];
  }

  Map toJson(){
    return {
      "surahId":_surahId,
      "verseId": _verseId,
      "surahName":_surahName,
      "surahArabic":_surahArabic,
      "juzId":_juzId,
      "juzName":_juzName,
      "isFromJuz":_isFromJuz,
      "bookmarkPosition":_bookmarkPosition
    };
  }
}