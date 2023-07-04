import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:nour_al_quran/pages/featured/models/featured.dart';
import 'package:nour_al_quran/pages/featured/models/miracles.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import '../../pages/basics_of_quran/models/islam_basics.dart';
import '../../pages/miracles_of_quran/models/miracles.dart';
import '../../pages/quran stories/models/quran_stories.dart';

class HomeDb {
  Database? _database;
  //tables
  final String _miraclesOfQuranTb = "miracles_of_quran";
  final String _storiesInQuran = "stories_in_quran";
  final String _islamBasicsTb = "islam_basics";
  final String _featured = "featured_all";
  initDb() async {
    var dbPath = await getDatabasesPath();
    var path = join(dbPath, 'masterdb.db');

    // Check if the database file already exists in the documents directory
    var exists = await databaseExists(path);

    if (!exists) {
      print('Database file does not exist in documents directory');
      try {
        await Directory(dirname(path)).create(recursive: true);
      } catch (_) {}
      // Copy the database file from the assets folder
      ByteData data = await rootBundle.load(join('assets', 'masterdb.db'));
      List<int> bytes =
          data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
      // Write and flush the bytes to the documents directory
      await File(path).writeAsBytes(bytes, flush: true);
      print('Database file copied to documents directory');
    } else {
      print('Database file already exists in documents directory');

      // Check for differences between the existing and assets database files
      ByteData assetsData =
          await rootBundle.load(join('assets', 'masterdb.db'));
      List<int> assetsBytes = assetsData.buffer
          .asUint8List(assetsData.offsetInBytes, assetsData.lengthInBytes);

      List<int> existingBytes = await File(path).readAsBytes();

      if (!listEquals(assetsBytes, existingBytes)) {
        // Delete the existing database file
        await File(path).delete();

        // Copy the updated database file from the assets folder
        ByteData newData = await rootBundle.load(join('assets', 'masterdb.db'));
        List<int> newBytes = newData.buffer
            .asUint8List(newData.offsetInBytes, newData.lengthInBytes);

        // Write and flush the new bytes to the documents directory
        await File(path).writeAsBytes(newBytes, flush: true);
        print('Updated database file copied to documents directory');
      } else {
        print(
            'Database file in assets is the same as the one in documents directory');
      }
    }
  }

  Future<Database> openDb() async {
    var dbPath = await getDatabasesPath();
    var path = join(dbPath, 'masterdb.db');
    return await openDatabase(path, readOnly: false);
  }

  Future<List<QuranStories>> getQuranStories() async {
    List<QuranStories> stories = [];
    _database = await openDb();
    var table = await _database!.query(_storiesInQuran);
    for (var map in table) {
      stories.add(QuranStories.fromJson(map));
    }
    return stories;
  }

  Future<List<FeaturedModel>> getFeatured() async {
    List<FeaturedModel> feature = [];
    _database = await openDb();
    var table = await _database!.query(_featured);
    print(
        "Table Length: ${table.length}"); // Print the number of rows retrieved from the table
    for (var map in table) {
      feature.add(FeaturedModel.fromJson(map));
    }
    print(
        "Feature Length: ${feature.length}"); // Print the number of FeaturedModel objects added to the list
    return feature;
  }

  Future<List<Miracles2>> getFeatured2() async {
    List<Miracles2> feature = [];
    _database = await openDb();
    var table = await _database!.query(_featured,where: "content_type = ?",whereArgs: ["Video"]);
    print(
        "Table Length: ${table.length}"); // Print the number of rows retrieved from the table
    for (var map in table) {
      feature.add(Miracles2.fromJson(map));
    }
    print(
        "Feature Length: ${feature.length}"); // Print the number of FeaturedModel objects added to the list
    return feature;
  }

  // by waqas
  /// i create this for getting only videos
  Future<List<Miracles>> getFeatured3() async {
    List<Miracles> feature = [];
    _database = await openDb();
    var table = await _database!.query(_featured,where: "content_type = ?",whereArgs: ["Video"]);
    print(
        "Table Length: ${table.length}"); // Print the number of rows retrieved from the table
    for (var map in table) {
      feature.add(Miracles.fromJson(map));
    }
    print(
        "Feature Length: ${feature.length}"); // Print the number of FeaturedModel objects added to the list
    return feature;
  }

  // Future<List<Chapters>> getChapters(int id) async {
  //   List<Chapters> chapters = [];
  //   _database = await openDb();
  //   var table = await _database!.rawQuery("SELECT Chapter_id,Chapter_name,text from stories_in_quran WHERE story_id = $id");
  //   for(var map in table){
  //     chapters.add(Chapters.fromJson(map));
  //   }
  //   return chapters;
  // }

  Future<List<Miracles>> getMiracles() async {
    List<Miracles> miracles = [];
    _database = await openDb();
    var table = await _database!.query(_miraclesOfQuranTb);
    for (var map in table) {
      miracles.add(Miracles.fromJson(map));
    }
    return miracles;
  }

  Future<List<IslamBasics>> getIslamBasics() async {
    List<IslamBasics> islamBasics = [];
    _database = await openDb();
    var table = await _database!.query(_islamBasicsTb);
    for (var map in table) {
      islamBasics.add(IslamBasics.fromJson(map));
    }
    return islamBasics;
  }
}
