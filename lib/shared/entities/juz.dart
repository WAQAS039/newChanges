class Juz{
  int? _juzId;
  String? _juzArabic;
  String? _juzEnglish;
  String? get juzArabic => _juzArabic;
  String? get juzEnglish => _juzEnglish;
  int? get juzId => _juzId;

  Juz({required juzId, required juzArabic, required juzEnglish,}){
    _juzId = juzId;
    _juzArabic = juzArabic;
    _juzEnglish = juzEnglish;
  }

  Juz.fromJson(Map<String,dynamic> json){
    _juzId = json['juz_id'];
    _juzArabic = json['juz_arabic'];
    _juzEnglish = json['juz_english'];
  }
}