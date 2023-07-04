import 'package:hive_flutter/adapters.dart';
import 'package:nour_al_quran/shared/utills/app_constants.dart';

class FeaturedModel {
  int? _storyId;
  String? _storyTitle;
  String? _image;
  String? _audioUrl;
  String? _text;
  String? _videoUrl;
  String? _contentType; // New field: content_type
  int? get storyId => _storyId;
  String? get storyTitle => _storyTitle;
  String? get image => _image;
  String? get videoUrl => _videoUrl;
  String? get audioUrl => _audioUrl;
  String? get text => _text;
  String? get contentType => _contentType;

  String? _title;

  String? get title => _title;

  // Getter for content_type

  FeaturedModel({
    required title,
    required storyId,
    required storyTitle,
    required image,
    required audio,
    required text,
    required video,
    required contentType, // New parameter: content_type
  }) {
    _title = title;
    _storyId = storyId;
    _storyTitle = storyTitle;
    _image = image;
    _audioUrl = audio;
    _text = text;
    _videoUrl = video;
    _contentType = contentType; // Assign the value to the content_type field
  }

  FeaturedModel.fromJson(Map<String, dynamic> json) {
    _title = json['miracle_title'];
    _storyId = json['story_id'];
    _storyTitle = json['story_title'];
    _image = json['app_image_url'];
    _audioUrl = json['content_url'];
    _text = json[Hive.box(appBoxKey).get(miraclesTranslationKey) ?? 'text'];
    _text = json['text'];
    _videoUrl = json['content_url'];
    _contentType =
        json['content_type']; // Assign the value to the content_type field
  }
}
