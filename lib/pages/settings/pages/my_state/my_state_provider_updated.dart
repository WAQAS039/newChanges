import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:nour_al_quran/pages/settings/pages/my_state/models/streak_level.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import '../../../../shared/utills/app_constants.dart';
import 'models/my_states.dart';

class MyStateProvider extends ChangeNotifier {
  /// table names
  final String _appUsageTimeTable = "appUsageTime";
  final String _quranReadingTimeTable = "quranReadingTime";
  final String _recitationTimeTable = "recitationTime";

  /// database instance
  late Database _database;

  /// these are the dynamic variables
  /// for managing state only
  int _appUsageSecondsElapsed = 0;
  int _quranReadingSecondsElapsed = 0;
  int _recitationSecondsElapsed = 0;

  /// current time to compare
  DateTime currentDate = DateTime.now();

  /// timer for each feature
  Timer? _appUsageTimer;
  Timer? _quranReadingTimer;
  Timer? _recitationTimer;

  /// drop down
  List<String> dropDown = ["Today", "Week", "Month", "Year"];

  /// your engagement feature variables
  int _yourEngagementAppUsageSeconds = 0;
  int get yourEngagementAppUsageSeconds => _yourEngagementAppUsageSeconds;
  bool _isAppUsageTimerRunning = false;

  /// current Select Item From YourEngagement dropdown
  String yourEngagementCurrentDropDownItem = "Today";

  /// weekly percentage
  double _weeklyPercentage = 0.0;
  double get weeklyPercentage => _weeklyPercentage;

  setYourEngagementCurrentDropDownItem(String value) {
    yourEngagementCurrentDropDownItem = value;
    notifyListeners();
  }

  /// Average Stats Feature
  /// these are the static variables
  /// for ui
  int _appUsageSeconds = 0;
  int _quranReadingSeconds = 0;
  int _recitationSeconds = 0;
  int _lifeTimeAppUsageSeconds = 0;
  int get lifeTimeAppUsageSeconds => _lifeTimeAppUsageSeconds;

  /// getters
  int get appUsageSeconds => _appUsageSeconds;
  int get quranReadingSeconds => _quranReadingSeconds;
  int get recitationSeconds => _recitationSeconds;

  /// Average Stats drop Down
  String averageStatsCurrentDropDownItem = "Today";
  setAverageStatsCurrentDropDownItem(String value) {
    averageStatsCurrentDropDownItem = value;
    notifyListeners();
  }

  bool isQuranReadingTimerWasInProgress = false;
  bool isRecitationTimerWasInProgress = false;

  /// this method is to init the db to save the time usage in
  /// that db where we have 4 tables for each section
  initUserDb() async {
    var dbPath = await getDatabasesPath();
    var path = join(dbPath, 'masterdb.db');

    /// Check if the database file already exists in the documents directory
    var exists = await databaseExists(path);
    if (!exists) {
      try {
        await Directory(dirname(path)).create(recursive: true);
      } catch (_) {}

      /// Copy the database file from the assets folder
      ByteData data = await rootBundle.load(join('assets', 'masterdb.db'));
      List<int> bytes =
          data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);

      /// Write and flush the bytes to the documents directory
      await File(path).writeAsBytes(bytes, flush: true);
    }
  }

  /// this method is used to open db to perform operation
  Future<Database> _openDb() async {
    var dbPath = await getDatabasesPath();
    var path = join(dbPath, 'masterdb.db');
    return await openDatabase(path, readOnly: false);
  }

  /// methods to start timers
  startAppUsageTimer() async {
    if (!_isAppUsageTimerRunning) {
      print("Timer Start");

      /// first of all get previous seconds from db to start from
      /// the same seconds elapsed
      _getAppUsageSecondElapsed();

      /// to ensure that timer should start only once
      _isAppUsageTimerRunning = true;
      notifyListeners();

      /// starting the timer
      _appUsageTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
        _appUsageSecondsElapsed++;
      });
    }
  }

  _getAppUsageSecondElapsed() async {
    _database = await _openDb();
    var map = await _database.query(_appUsageTimeTable,
        where: "date = ?",
        whereArgs: [currentDate.toString().substring(0, 10)]);
    if (map.isNotEmpty) {
      _appUsageSecondsElapsed = map.first['secondsElapsed'] as int;
      _appUsageSeconds = map.first['secondsElapsed'] as int;
      _yourEngagementAppUsageSeconds = map.first['secondsElapsed'] as int;
      notifyListeners();
    }
  }

  /// here from Where Means That from Which Class we Call this
  /// method so we are calling this from quran text view when
  /// user start reading holy quran and if user stop the app
  /// and was in quran reading section so when user will resume
  /// app again so timer will again start automatically
  startQuranReadingTimer(String fromWhere) {
    print("Reading Timer Start");

    /// first of all get previous quran reading seconds from db to start from
    /// the same seconds elapsed
    getTodayQuranReadingSecondsElapsed();

    /// so home means it was called from the [didChangeAppLifecycleState]
    /// method which exist in [bottom_tab_page] screen
    if (fromWhere == "home") {
      if (isQuranReadingTimerWasInProgress) {
        print("From Home In Progress Reading Timer Start");
        _quranReadingTimer =
            Timer.periodic(const Duration(seconds: 1), (timer) {
          _quranReadingSecondsElapsed++;
        });
      }
    } else {
      print("From else Not In Progress Reading Timer Start");
      isQuranReadingTimerWasInProgress = false;
      notifyListeners();

      /// start quran reading timer if user is reading quran
      _quranReadingTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
        _quranReadingSecondsElapsed++;
      });
    }
  }

  startQuranRecitationTimer(String fromWhere) {
    print("Recitation Timer Start");

    /// first of all get previous recitation seconds from db to start from
    /// the same seconds elapsed
    getTodayRecitationSecondsElapsed();

    if (fromWhere == "home") {
      if (isRecitationTimerWasInProgress) {
        print("From Home In Progress Recitation Timer Start");
        _recitationTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
          _recitationSecondsElapsed++;
        });
      }
    } else {
      isRecitationTimerWasInProgress = false;
      notifyListeners();

      /// start recitation timer if user start recitation of any Reciter
      _recitationTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
        _recitationSecondsElapsed++;
      });
    }
  }

  /// methods to stop timers
  stopAppUsageTimer() async {
    /// check timer is running or not
    if (_isAppUsageTimerRunning) {
      /// first make it false to start timer again
      _isAppUsageTimerRunning = false;
      notifyListeners();

      print("Timer Cancel");

      /// cancel timer
      _appUsageTimer!.cancel();

      /// do the saving process to save time in db
      var now = DateTime.now();
      var myState = MyStates(
          date: now.toString().substring(0, 10),
          dayName: DateFormat('EEEE').format(now),
          seconds: _appUsageSecondsElapsed);
      insertDataToDb(_appUsageTimeTable, myState);
    }
  }

  _setIsQuranReadingWasInProgress(bool value) {
    isQuranReadingTimerWasInProgress = value;
    notifyListeners();
  }

  _setIsRecitationTimerWasInProgress(bool value) {
    isRecitationTimerWasInProgress = value;
    notifyListeners();
  }

  stopQuranReadingTimer(String fromWhere) {
    if (_quranReadingTimer != null) {
      if (fromWhere == "home") {
        _setIsQuranReadingWasInProgress(true);
      } else {
        _setIsQuranReadingWasInProgress(false);
      }
      print("Reading Timer Cancel");
      _quranReadingTimer!.cancel();
      var now = DateTime.now();
      var myState = MyStates(
          date: now.toString().substring(0, 10),
          dayName: DateFormat('EEEE').format(now),
          seconds: _quranReadingSecondsElapsed);
      insertDataToDb(_quranReadingTimeTable, myState);
    } else {
      _setIsQuranReadingWasInProgress(false);
      getTodayQuranReadingSecondsElapsed();

      /// if timer not started so add 0 seconds for today
      /// that means user didn't read quran today
      /// this is for having every single day record even user read quran or not
      var now = DateTime.now();
      var myState = MyStates(
          date: now.toString().substring(0, 10),
          dayName: DateFormat('EEEE').format(now),
          seconds: _quranReadingSecondsElapsed);
      insertDataToDb(_quranReadingTimeTable, myState);
    }
  }

  stopRecitationTimer(String fromWhere) {
    if (_recitationTimer != null) {
      if (fromWhere == "home") {
        _setIsRecitationTimerWasInProgress(true);
      } else {
        _setIsRecitationTimerWasInProgress(false);
      }
      print("Recitation Timer Cancel");
      _recitationTimer!.cancel();
      var now = DateTime.now();
      var myState = MyStates(
          date: now.toString().substring(0, 10),
          dayName: DateFormat('EEEE').format(now),
          seconds: _recitationSecondsElapsed);
      insertDataToDb(_recitationTimeTable, myState);
    } else {
      _setIsRecitationTimerWasInProgress(false);
      getTodayRecitationSecondsElapsed();

      /// if timer not started so add 0 seconds for today
      /// that means user didn't played any quran surah today
      var now = DateTime.now();
      var myState = MyStates(
          date: now.toString().substring(0, 10),
          dayName: DateFormat('EEEE').format(now),
          seconds: _recitationSecondsElapsed);
      insertDataToDb(_recitationTimeTable, myState);
    }
  }

  stopAllTimer() {
    stopAppUsageTimer();
    stopQuranReadingTimer("home");
    stopRecitationTimer("home");
  }

  /// this method is used to save seconds elapsed in db
  /// and it is used for all three sections
  insertDataToDb(String tableName, MyStates myState) async {
    _database = await _openDb();

    /// Check if there is an existing row in the database for current date
    final count = Sqflite.firstIntValue(await _database.rawQuery(
        'SELECT COUNT(*) FROM $tableName WHERE date = ?', [myState.date]));
    if (count == 0) {
      // If there is no existing row, insert the initial value of the timer for current date
      await _database.insert(tableName, myState.toJson());
    } else {
      /// Otherwise, update the existing row with the new value of the timer for current date
      await _database.update(
        tableName,
        {'secondsElapsed': myState.secondsElapsed},
        where: 'date = ?',
        whereArgs: [myState.date],
      );
    }
  }

  getTodayAppUsageSecondsElapsed(String fromWhichDropDown) async {
    var map = await _database.query(_appUsageTimeTable,
        where: "date = ?",
        whereArgs: [currentDate.toString().substring(0, 10)]);
    if (map.isNotEmpty) {
      if (fromWhichDropDown == "engagement") {
        _yourEngagementAppUsageSeconds = map.first['secondsElapsed'] as int;
      } else {
        _appUsageSeconds = map.first['secondsElapsed'] as int;
      }
    } else {
      if (fromWhichDropDown == "engagement") {
        _yourEngagementAppUsageSeconds = 0;
      }
    }
    notifyListeners();
  }

  getTodayQuranReadingSecondsElapsed() async {
    _database = await _openDb();
    var map = await _database.query(_quranReadingTimeTable,
        where: "date = ?",
        whereArgs: [currentDate.toString().substring(0, 10)]);
    if (map.isNotEmpty) {
      _quranReadingSecondsElapsed = map.first['secondsElapsed'] as int;
      _quranReadingSeconds = map.first['secondsElapsed'] as int;
      notifyListeners();
    }
  }

  getTodayRecitationSecondsElapsed() async {
    _database = await _openDb();
    var map = await _database.query(_recitationTimeTable,
        where: "date = ?",
        whereArgs: [currentDate.toString().substring(0, 10)]);
    if (map.isNotEmpty) {
      _recitationSecondsElapsed = map.first['secondsElapsed'] as int;
      _recitationSeconds = map.first['secondsElapsed'] as int;
      notifyListeners();
    }
  }

  /// this method is called from on tab of drop down item
  /// so drop down could be your engagement drop down or average state drop down
  /// from which drop down means that is it from your engagement drop down or from average state drop down
  /// get Seconds To Update UI
  getSeconds(String time, String fromWhichDropDown) {
    if (time == "Today") {
      getTodayAppUsageSecondsElapsed(fromWhichDropDown);
      getTodayQuranReadingSecondsElapsed();
      getTodayRecitationSecondsElapsed();
    } else if (time == "Week") {
      getWeeklySecondsUsage(fromWhichDropDown);
    } else if (time == "Month") {
      getMonthlySecondUsage(fromWhichDropDown);
    } else {
      getYearlySecondUsage(fromWhichDropDown);
    }
  }

  /// this method will provide weekly result for both your engagement as well as average state drop down
  getWeeklySecondsUsage(String fromWhichDropDown) async {
    final dateToday = DateTime.now();
    final firstDayOfWeek =
        dateToday.subtract(Duration(days: dateToday.weekday - 1));
    final lastDayOfWeek = firstDayOfWeek.add(const Duration(days: 6));
    _database = await _openDb();
    await _database.rawQuery(
      'SELECT SUM(secondsElapsed) AS total_seconds, date FROM $_appUsageTimeTable WHERE date BETWEEN ? AND ? GROUP BY strftime("%W", date) ORDER BY date DESC',
      [
        firstDayOfWeek
            .subtract(const Duration(days: 7))
            .toString()
            .substring(0, 10),
        lastDayOfWeek.toString().substring(0, 10),
      ],
    ).then((value) async {
      if (value.isNotEmpty) {
        if (fromWhichDropDown == "engagement") {
          _yourEngagementAppUsageSeconds = value.first['total_seconds'] as int;
        } else {
          _appUsageSeconds = value.first['total_seconds'] as int;
          await _database.rawQuery(
            'SELECT SUM(secondsElapsed) AS total_seconds, date FROM $_quranReadingTimeTable WHERE date BETWEEN ? AND ? GROUP BY strftime("%W", date) ORDER BY date DESC',
            [
              firstDayOfWeek
                  .subtract(const Duration(days: 7))
                  .toString()
                  .substring(0, 10),
              lastDayOfWeek.toString().substring(0, 10)
            ],
          ).then((value) async {
            if (value.isNotEmpty) {
              _quranReadingSeconds = value.first['total_seconds'] as int;
              notifyListeners();
              print(_quranReadingSeconds);
            }
            await _database.rawQuery(
              'SELECT SUM(secondsElapsed) AS total_seconds, date FROM $_recitationTimeTable WHERE date BETWEEN ? AND ? GROUP BY strftime("%W", date) ORDER BY date DESC',
              [
                firstDayOfWeek
                    .subtract(const Duration(days: 7))
                    .toString()
                    .substring(0, 10),
                lastDayOfWeek.toString().substring(0, 10)
              ],
            ).then((value) {
              if (value.isNotEmpty) {
                _recitationSeconds = value.first['total_seconds'] as int;
                notifyListeners();
                print(_recitationSeconds);
              }
            });
          });
        }
        notifyListeners();
        print(_appUsageSeconds);
      }
    });
  }

  getMonthlySecondUsage(String fromWhichDropDown) async {
    final dateToday = DateTime.now();
    final currentMonth = dateToday.month;
    final currentYear = dateToday.year;
    _database = await _openDb();
    await _database.rawQuery(
      'SELECT SUM(secondsElapsed) AS total_seconds, strftime("%Y-%m", date) AS month FROM $_appUsageTimeTable WHERE strftime("%m", date) >= ? AND strftime("%Y", date) = ? GROUP BY month ORDER BY month DESC',
      [(currentMonth - 3).toString().padLeft(2, '0'), currentYear.toString()],
    ).then((value) async {
      if (value.isNotEmpty) {
        if (fromWhichDropDown == "engagement") {
          _yourEngagementAppUsageSeconds = value.first['total_seconds'] as int;
        } else {
          _appUsageSeconds = value.first['total_seconds'] as int;
          await _database.rawQuery(
            'SELECT SUM(secondsElapsed) AS total_seconds, strftime("%Y-%m", date) AS month FROM $_quranReadingTimeTable WHERE strftime("%m", date) >= ? AND strftime("%Y", date) = ? GROUP BY month ORDER BY month DESC',
            [
              (currentMonth - 3).toString().padLeft(2, '0'),
              currentYear.toString()
            ],
          ).then((value) async {
            if (value.isNotEmpty) {
              _quranReadingSeconds = value.first['total_seconds'] as int;
              notifyListeners();
              print(_quranReadingSeconds);
            }
            await _database.rawQuery(
              'SELECT SUM(secondsElapsed) AS total_seconds, strftime("%Y-%m", date) AS month FROM $_recitationTimeTable WHERE strftime("%m", date) >= ? AND strftime("%Y", date) = ? GROUP BY month ORDER BY month DESC',
              [
                (currentMonth - 3).toString().padLeft(2, '0'),
                currentYear.toString()
              ],
            ).then((value) {
              if (value.isNotEmpty) {
                _recitationSeconds = value.first['total_seconds'] as int;
                notifyListeners();
                print(_recitationSeconds);
              }
            });
          });
        }
        notifyListeners();
        print(_appUsageSecondsElapsed);
      }
    });
  }

  getYearlySecondUsage(String fromWhichDropDown) async {
    final dateToday = DateTime.now();
    final currentYear = dateToday.year;
    final previousYear = currentYear - 1;
    _database = await _openDb();
    await _database.rawQuery(
      'SELECT SUM(secondsElapsed) AS total_seconds, strftime("%Y", date) AS year FROM $_appUsageTimeTable WHERE strftime("%Y", date) IN (?, ?) GROUP BY year ORDER BY year DESC',
      [currentYear.toString(), previousYear.toString()],
    ).then((value) async {
      if (value.isNotEmpty) {
        /// first if to update your engagement data
        if (fromWhichDropDown == "engagement") {
          _yourEngagementAppUsageSeconds = value.first['total_seconds'] as int;
        } else {
          /// else to update average state data
          _appUsageSeconds = value.first['total_seconds'] as int;
          await _database.rawQuery(
            'SELECT SUM(secondsElapsed) AS total_seconds, strftime("%Y", date) AS year FROM $_quranReadingTimeTable WHERE strftime("%Y", date) IN (?, ?) GROUP BY year ORDER BY year DESC',
            [currentYear.toString(), previousYear.toString()],
          ).then((value) async {
            if (value.isNotEmpty) {
              _quranReadingSeconds = value.first['total_seconds'] as int;
              notifyListeners();
              print(_quranReadingSeconds);
            }
            await _database.rawQuery(
              'SELECT SUM(secondsElapsed) AS total_seconds, strftime("%Y", date) AS year FROM $_recitationTimeTable WHERE strftime("%Y", date) IN (?, ?) GROUP BY year ORDER BY year DESC',
              [currentYear.toString(), previousYear.toString()],
            ).then((value) {
              if (value.isNotEmpty) {
                _recitationSeconds = value.first['total_seconds'] as int;
                notifyListeners();
                print(_recitationSeconds);
              }
            });
          });
        }
        notifyListeners();
      }
    });
  }

  /// get life time seconds means to get all the seconds from each rows and sum together
  /// this is for home page
  getLifeTimeAppUsageSeconds() async {
    _database = await _openDb();
    _database
        .rawQuery(
            'SELECT SUM(secondsElapsed) AS total_seconds FROM $_appUsageTimeTable')
        .then((value) {
      if (value.isNotEmpty) {
        if (value.first['total_seconds'] != null) {
          _lifeTimeAppUsageSeconds = value.first['total_seconds'] as int;
          notifyListeners();
        }
      }
    });
  }

  /// 21% from last week
  Future<double> getWeeklyPercentageDifference() async {
    // Get today's date and calculate the first day of the current week
    final now = DateTime.now();
    final firstDayOfWeek = DateTime(now.year, now.month, now.day)
        .subtract(Duration(days: now.weekday - 1));

    // Calculate the first day of the previous week
    final firstDayOfPreviousWeek =
        firstDayOfWeek.subtract(const Duration(days: 7));

    // Query the database to get the seconds elapsed for the current week
    final currentWeekSecondsElapsed =
        await _getSecondsElapsedInRange(firstDayOfWeek, now) as int;

    // Query the database to get the seconds elapsed for the previous week
    final previousWeekSecondsElapsed = await _getSecondsElapsedInRange(
        firstDayOfPreviousWeek,
        firstDayOfWeek.subtract(const Duration(days: 1))) as int;

    // Calculate the percentage difference between the current week and the previous week
    double percentageDifference = 0;
    if (previousWeekSecondsElapsed != 0) {
      percentageDifference =
          (currentWeekSecondsElapsed - previousWeekSecondsElapsed) /
              previousWeekSecondsElapsed *
              100;
    }
    _weeklyPercentage = percentageDifference;
    notifyListeners();
    print(_weeklyPercentage);
    // Return the percentage difference
    return percentageDifference;
  }

  Future<Object> _getSecondsElapsedInRange(
      DateTime startDate, DateTime endDate) async {
    _database = await _openDb();
    // Query the database to get the total seconds elapsed in the specified date range
    final result = await _database.rawQuery(
        'SELECT SUM(secondsElapsed) FROM $_appUsageTimeTable WHERE date BETWEEN ? AND ?',
        [
          startDate.toString().substring(0, 10),
          endDate.toString().substring(0, 10)
        ]);
    // Return the total seconds elapsed (or 0 if no rows were returned)
    return result.first.values.first ?? 0;
  }

  /// weekly engagement list
  /// this list is for bar chart
  /// in this method we will get 7 rows data to display weekly results on bar chart
  var weeklyAppUsageList = <MyStates>[];
  int averageTimePerDay = 0;
  getWeeklyAppEngagement() async {
    _database = await _openDb();
    var table = await _database.query(_appUsageTimeTable,
        limit: 7, orderBy: "date DESC");
    if (table.isNotEmpty && table.length >= 7) {
      int totalSeconds = 0;
      for (var map in table) {
        weeklyAppUsageList.add(MyStates.fromJson(map));
        totalSeconds += map['secondsElapsed'] as int;
      }
      averageTimePerDay = totalSeconds ~/ 7;
      notifyListeners();
    }
  }

  StreakLevel? streak = Hive.box(appBoxKey).get(streakLevelKey) != null
      ? StreakLevel.fromJson(
          jsonDecode(Hive.box(appBoxKey).get(streakLevelKey)))
      : null;
  double maxStreak = 10.0;

  void updateStreak() {
    // Get the current date
    DateTime currentDate = DateTime.now();

    if (streak != null) {
      print("streak was Null");
      // Get the last opened date from Hive
      DateTime lastOpenedDate = DateTime.parse(streak!.lastOpen!);

      // Check if there was a gap in opening the app
      bool hasGap = currentDate.difference(lastOpenedDate).inDays > 1;

      if (hasGap) {
        print("reset streak comming after gap");
        // Reset the streak to 0
        streak = StreakLevel(
            lastOpen: currentDate.toIso8601String(), streakLevel: 0);
        Hive.box(appBoxKey).put(streakLevelKey, jsonEncode(streak));
      } else {
        print("no  gap init increment");
        // Check if the streak has already been incremented today
        bool alreadyIncremented = lastOpenedDate.day == currentDate.day;
        if (!alreadyIncremented) {
          print("already increment");
          // Increment the streak
          // _streak = _streak! + 1;
          streak = StreakLevel(
              lastOpen: DateTime.now().toIso8601String(),
              streakLevel: streak!.streakLevel! + 1);
          Hive.box(appBoxKey).put(streakLevelKey, jsonEncode(streak));
        }
      }
    } else {
      print("init streak for first time");
      streak = StreakLevel(
          lastOpen: DateTime.now().toIso8601String(), streakLevel: 1);
      Hive.box(appBoxKey).put(streakLevelKey, jsonEncode(streak));
    }
    notifyListeners();
  }
}
