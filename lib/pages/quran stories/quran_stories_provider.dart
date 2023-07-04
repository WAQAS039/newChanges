// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:nour_al_quran/shared/database/home_db.dart';
import 'package:nour_al_quran/shared/providers/story_n_basics_audio_player_provider.dart';
import 'package:nour_al_quran/shared/routes/routes_helper.dart';

import 'models/quran_stories.dart';

class QuranStoriesProvider extends ChangeNotifier {
  List<QuranStories> _stories = [];
  List<QuranStories> get stories => _stories;
  int _currentStoryIndex = 0;
  int get currentStoryIndex => _currentStoryIndex;
  QuranStories? _selectedQuranStory;
  QuranStories? get selectedQuranStory => _selectedQuranStory;
  SharedPreferences? _preferences;
  Future<void> getStories() async {
    _stories = await HomeDb().getQuranStories();
    _loadStoriesOrder();
    notifyListeners();
  }

  QuranStoriesProvider() {
    _initSharedPreferences();
  }

  Future<void> _initSharedPreferences() async {
    _preferences = await SharedPreferences.getInstance();
  }

  void goToStoryContentPage(int index, BuildContext context) {
    _currentStoryIndex = index;
    _selectedQuranStory =
        _stories[index]; // Move the selected story to the end of the list
    notifyListeners();
    Navigator.of(context).pushNamed(RouteHelper.storyDetails);
    _moveStoryToEnd(index);
  }

  gotoStoryPlayerPage(int storyId, BuildContext context, int index) {
    _currentStoryIndex =
        _stories.indexWhere((element) => element.storyId == storyId);
    _selectedQuranStory = _stories[_currentStoryIndex];
    Provider.of<StoryAndBasicPlayerProvider>(context, listen: false)
        .initAudioPlayer(
            _selectedQuranStory!.audioUrl!,
            "assets/images/quran_stories/${selectedQuranStory!.image}",
            context);
    Navigator.of(context)
        .pushNamed(RouteHelper.storyPlayer, arguments: 'fromStory');
  }

  void _moveStoryToEnd(int index) {
    Future.delayed(Duration(milliseconds: 300), () {
      _stories.removeAt(index);
      _stories.add(_selectedQuranStory!);
      notifyListeners();
      _saveStoriesOrder();
    });
  }

  void _saveStoriesOrder() async {
    final List<String> order =
        _stories.map((stories) => stories.storyTitle!).toList();
    _preferences?.setStringList('stories_order', order);
  }

  void _loadStoriesOrder() async {
    final List<String>? order = _preferences?.getStringList('stories_order');

    if (order != null && order.isNotEmpty) {
      // Add a check for non-empty order
      final List<QuranStories> sortedStories = [];
      for (final storyTitle in order) {
        final story = _stories.firstWhere(
          (m) => m.storyTitle == storyTitle,
        );
        if (story != null) {
          sortedStories.add(story);
        }
      }
      _stories = sortedStories;
      notifyListeners();
    }
  }
}
