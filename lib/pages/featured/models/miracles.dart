import 'package:fluttertoast/fluttertoast.dart';
import 'package:hive/hive.dart';

import '../../../shared/utills/app_constants.dart';

class Miracles2 {
  String? _title;
  String? _image;
  String? _text;
  String? _videoUrl;

  String? get title => _title;

  String? get image => _image;

  String? get text => _text;

  String? get videoUrl => _videoUrl;

  Miracles2({required title, required image, required text, required video}) {
    _title = title;
    _image = image;
    _text = text;
    _videoUrl = video;
  }

  Miracles2.fromJson(Map<String, dynamic> json) {
    _title = json['miracle_title'];
    _image = json['app_image_url'];
    _text = json[Hive.box(appBoxKey).get(miraclesTranslationKey) ?? 'text'];
    // json['text'];
    _videoUrl = json['content_url'];
  }
}
