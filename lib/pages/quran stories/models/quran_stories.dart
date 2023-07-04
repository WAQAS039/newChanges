class QuranStories {
  int? _storyId;
  String? _storyTitle;
  String? _image;
  String? _audioUrl;
  String? _text;

  int? get storyId => _storyId;
  String? get storyTitle => _storyTitle;
  String? get image => _image;

  String? get audioUrl => _audioUrl;
  String? get text => _text;

  QuranStories(
      {required storyId,
      required storyTitle,
      required image,
      required audio,
      required text}) {
    _storyId = storyId;
    _storyTitle = storyTitle;
    _image = image;
    _audioUrl = audio;
    _text = text;
  }

  QuranStories.fromJson(Map<String, dynamic> json) {
    _storyId = json['story_id'];
    _storyTitle = json['story_title'];
    _image = json['app_image_url'];
    _audioUrl = json['content_url'];
    _text = json['text'];
  }
}
