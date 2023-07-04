class Translations{
  String? _title;
  String? _image;
  String? _url;
  String? _translationName;
  String? _bissmillah;
  String? _duaTranslation;

  String? get title => _title;
  String? get image => _image;
  String? get url => _url;
  String? get translationName => _translationName;
  String? get bismillah => _bissmillah;
  String? get duaTranslation => _duaTranslation;

  Translations({required title, required image,required url,required translationName,required bis,required duaTrans}){
    _title = title;
    _image = image;
    _url = url;
    _translationName = translationName;
    _bissmillah = bis;
    _duaTranslation = duaTrans;
  }

  Translations.fromJson(Map<String,dynamic> json){
    _title = json['title'];
    _image = json['image'];
    _url = json['url'];
    _translationName = json['translationName'];
    _bissmillah = json['bissmillah'];
    _duaTranslation = json['duaTranslation'];
  }

  Map toJson(){
    return {
      "title" : _title,
      "image" : _image,
      "url" : _url,
      "translationName" : _translationName,
      "bissmillah" : _bissmillah,
      "duaTranslation" : _duaTranslation
    };
  }
}