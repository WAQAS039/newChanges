import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:nour_al_quran/pages/onboarding/models/fav_reciter.dart';
import 'package:nour_al_quran/pages/settings/pages/notifications/notification_services.dart';
import 'package:nour_al_quran/shared/utills/app_constants.dart';

import 'models/common.dart';

class OnBoardingProvider extends ChangeNotifier {
  // achieve functionality

  final List<String> _achieveWithQuranList = [
    "stream/download_reciters",
    "read_offline_quran",
    "set_quran_goals",
    "explore_the_quran",
    "translations_&_reflection",
    "learn_the_qaida",
  ];
  List<String> get achieveWithQuranList => _achieveWithQuranList;
  final List<String> _selectAchieveWithQuranList = [];
  List<String> get selectAchieveWithQuranList => _selectAchieveWithQuranList;

  void addAchieveItem(String item, int index, BuildContext context) {
    if (!_selectAchieveWithQuranList.contains(item)) {
      if (selectAchieveWithQuranList.length < 3) {
        _selectAchieveWithQuranList.add(item);
      } else {
        ScaffoldMessenger.of(context)
          ..removeCurrentSnackBar()
          ..showSnackBar(const SnackBar(
            content: Text("U Can Select Only Three Goals"),
            duration: Duration(milliseconds: 500),
          ));
      }
    } else {
      _selectAchieveWithQuranList.removeWhere((element) => element == item);
    }
    notifyListeners();
  }

  // set fav reciter functionality
  final List<FavReciter> _reciterList = [
    FavReciter(
        title: "Abdur- Rahman As- Sudais",
        isPlaying: false,
        audioUrl: "assets/audios/fav_reciters/Abdur- Rahman As- Sudais.mp3",
        reciterId: 11),
    FavReciter(
        title: "Mahmoud Al-Hussary",
        isPlaying: false,
        audioUrl: "assets/audios/fav_reciters/Mahmoud Al-Hussary.mp3",
        reciterId: 20),
    FavReciter(
        title: "Mishary Al Afsay",
        isPlaying: false,
        audioUrl: "assets/audios/fav_reciters/Mishary Al Afsay.mp3",
        reciterId: 10),
    FavReciter(
        title: "Sheikh Maher Muaqily",
        isPlaying: false,
        audioUrl: "assets/audios/fav_reciters/Sheikh Maher Muaqily.mp3",
        reciterId: 4),
    FavReciter(
        title: "Sheikh Saud Al-Shuraim",
        isPlaying: false,
        audioUrl: "assets/audios/fav_reciters/Sheikh Saud Al-Shuraim.mp3",
        reciterId: 14),
  ];
  List<FavReciter> get reciterList => _reciterList;

  String favReciter = "Abdur- Rahman As- Sudais";

  final AudioPlayer _audioPlayer = AudioPlayer();

  initAudioPlayer(String audio) async {
    _audioPlayer.setAsset(audio);
    await _audioPlayer.play();
  }

  void setFavReciter(int index) {
    favReciter = _reciterList[index].title!;
    notifyListeners();
  }

  Future<void> setIsPlaying(int index) async {
    if (!_reciterList[index].isPlaying!) {
      _reciterList[index].setIsPlaying = true;
      _audioPlayer.setAsset(_reciterList[index].audioUrl!);
      await _audioPlayer.play();
      _audioPlayer.playerStateStream.listen((event) {
        if (event.processingState == ProcessingState.completed) {
          _reciterList[index].setIsPlaying = false;
          notifyListeners();
        }
      });
    }
    notifyListeners();
  }

  // set like to recite
  final List<String> _likeToRecite = [
    "morning",
    "afternoon",
    "evening",
    "night"
  ];
  List<String> get likeToRecite => _likeToRecite;

  String selectTimeLikeToRecite = "morning";

  void selectTimeToRecite(int index) {
    selectTimeLikeToRecite = _likeToRecite[index];
    notifyListeners();
  }

  // set dailyQuran time
  final List<String> _dailyTime = [
    "5_minutes",
    "10_minutes",
    "15_minutes",
    "20_minutes",
    "30_minutes"
  ];

  List<String> get dailyTime => _dailyTime;

  String selectedDailyTime = "5_minutes";

  void selectDailyTime(int index) {
    selectedDailyTime = _dailyTime[index];
    notifyListeners();
  }

  // recitation Reminder
  final TimeOfDay _recitationReminderTime = TimeOfDay.now();
  TimeOfDay get recitationReminderTime =>
      _recitationReminderTime; // set notification

  // void setRecitationReminderTime(TimeOfDay dateTime){
  //   _recitationReminderTime = dateTime;
  //   notifyListeners();
  // }

  // set notifications
  final List<Common> _notification = [
    Common(title: "daily_quran_recitation_reminder", isSelected: true),
    Common(title: "daily_quran_verse", isSelected: true),
    // Common(title: "Dua Reminder", isSelected: true),
    Common(title: "daily_salah_reminder", isSelected: true),
    Common(title: "friday_prayer_reminder", isSelected: true),
  ];

  List<Common> get notification => _notification;
  void setNotification(int index, bool value) {
    _notification[index].setIsSelected = value;
    notifyListeners();
    if (index == 0 && value == false) {
      NotificationServices().cancelNotifications(dailyQuranRecitationId);
    } else if (index == 1 && value == false) {
      NotificationServices().cancelNotifications(dailyVerseNotificationId);
    }
  }
}
