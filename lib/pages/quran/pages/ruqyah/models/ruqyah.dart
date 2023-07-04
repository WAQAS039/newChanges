import 'package:hive/hive.dart';
import 'package:nour_al_quran/shared/utills/app_constants.dart';

class Ruqyah {
  int? _id;
  int? _duaCategory;
  String? _duaText;
  String? _duatitle;
  String? _duaRef;
  String? _translations;
  String? _contentUrl;
  int? _ayahCount;
  int? _isFav;
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
  int? get duaNo => _duaNo;

  set setIsBookmark(int value) => _isFav = value;

  Ruqyah({
    required id,
    required duaCategory,
    required duaText,
    required duaRef,
    required translations,
    required duaTitle,
    required duaUrl,
    required ayahCount,
    required isFav,
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
    _duaNo = duaNo;
  }

  Ruqyah.fromJson(Map<String, dynamic> json) {
    _id = json['ruqyah_id'];
    _duaCategory = json['category_id'];
    _duaText = json['ruqyah_text'];
    _duatitle = json['ruqyah_title'];
    _duaRef = json['ref'];
    _translations = json[
        Hive.box(appBoxKey).get(duaTranslationKey) ?? 'translation_english'];
    _contentUrl = json['content_url'];
    _ayahCount = json['ayah_count'];
    _isFav = json['is_fav'];
    _duaNo = json['dua_no'];
  }

  Map<String, dynamic> toJson() {
    return {
      'ruqyah_id': _id,
      'category_id': _duaCategory,
      'ruqyah_text': _duaText,
      'ruqyah_title': _duatitle,
      'ref': _duaRef,
      'translation_english': _translations,
      'content_url': _contentUrl,
      'ayah_count': _ayahCount,
      'is_fav': _isFav,
      'dua_no': _duaNo,
    };
  }

  @override
  String toString() {
    return 'Dua: duaId=$id,duaTitle=$duaTitle, duaText=$duaText, translations=$translations, duaRef=$duaRef';
  }
}
