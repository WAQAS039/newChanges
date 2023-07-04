import 'package:hive/hive.dart';
import 'package:nour_al_quran/shared/utills/app_constants.dart';

class Dua {
  int? _id;
  int? _duaCategory;
  String? _duaText;
  String? _duatitle;
  String? _duaRef;
  String? _translations;
  String? _contentUrl;
  int? _ayahCount;
  int? _isFav;
  String? _status;
  int? _duaNo;

  int? get id => _id;
  int? get duaCategory => _duaCategory;
  String? get translations => _translations;
  String? get duaRef => _duaRef;
  String? get duaText => _duaText;
  String? get duaTitle => _duatitle;
  String? get duaUrl => _contentUrl;
  int? get ayahCount => _ayahCount;
  int? get isFav => _isFav;
  String? get status => _status;
  int? get duaNo => _duaNo;
  set setIsBookmark(int value) => _isFav = value;

  Dua({
    required id,
    required duaCategory,
    required duaText,
    required duaRef,
    required translations,
    required duaTitle,
    required duaUrl,
    required ayahCount,
    required isFav,
    required status,
    required duaNo,
  }) {
    _id = id;
    _duaCategory = duaCategory;
    _duaText = duaText;
    _duaRef = duaRef;
    _translations = translations;
    _duatitle = duaTitle;
    _contentUrl = duaUrl;
    _ayahCount = ayahCount;
    _isFav = isFav;
    _status = status;
    _duaNo = duaNo;
  }

  Dua.fromJson(Map<String, dynamic> json) {
    _id = json['dua_id'];
    _duaCategory = json['category_id'];
    _duaText = json['dua_text'];
    _duatitle = json['dua_title'];
    _duaRef = json['dua_ref'];
    _translations = json[
        Hive.box(appBoxKey).get(duaTranslationKey) ?? 'translation_english'];
    _contentUrl = json['content_url'];
    _ayahCount = json['ayah_count'];
    _isFav = json['is_fav'];
    _status = json['status'];
    _duaNo = json['dua_no'];
  }

  Map<String, dynamic> toJson() {
    return {
      'dua_id': _id,
      'category_id': _duaCategory,
      'dua_text': _duaText,
      'dua_title': _duatitle,
      'dua_ref': _duaRef,
      'translations': _translations,
      'content_url': _contentUrl,
      'ayah_count': _ayahCount,
      'is_fav': _isFav,
      'status': _status,
      'dua_no': _duaNo,
    };
  }

  @override
  String toString() {
    return 'Dua: duaId=$id,duaTitle=$duaTitle, duaText=$duaText, translations=$translations, duaRef=$duaRef, totalAyaat=$ayahCount, isFAV ? $isFav, status > $status';
  }
}
