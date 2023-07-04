import 'dart:io';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:nour_al_quran/pages/settings/pages/translation_manager/translation_manager_provider.dart';
import 'package:nour_al_quran/shared/entities/bookmarks.dart';
import 'package:nour_al_quran/shared/entities/bookmarks_dua.dart';
import 'package:nour_al_quran/shared/entities/bookmarks_ruqyah.dart';
import 'package:nour_al_quran/shared/entities/juz.dart';
import 'package:nour_al_quran/shared/entities/quran_text.dart';
import 'package:nour_al_quran/shared/entities/reciters.dart';
import 'package:nour_al_quran/shared/entities/surah.dart';
import 'package:provider/provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../../pages/duas/models/dua.dart';
import '../../pages/duas/models/dua_category.dart';
import '../../pages/quran/pages/ruqyah/models/ruqyah.dart';
import '../../pages/quran/pages/ruqyah/models/ruqyah_category.dart';

class QuranDatabase {
  Database? database;
  final String _quranTextTable = "quran_text";
  final String _surahNameTable = "surah";
  final String _duaAllTable = "duas_all";
  final String _duaCategoryTable = "dua_category";
  final String _reciterTable = "reciters";

  final String _juzListTable = "juz_list";
  //final String _bookmarkNameTable = "BookMarksList";

  final String _rduaAllTable = "al_ruqyah_all";
  final String _rduaCatergoryTable = "ruqyah_category";

  // to load all Ruqyah duas category names
  Future<List<Ruqyah>> getRDua(int categoryId) async {
    database = await openDb();
    var duaList = <Ruqyah>[];
    var cursor = await database!.query(_rduaAllTable,
        where: "category_id = ?", whereArgs: [categoryId]);
    for (var maps in cursor) {
      var dua = Ruqyah.fromJson(maps);
      duaList.add(dua);
    }
    return duaList;
  }

  // to load all duas category names
  Future<List<RuqyahCategory>> getRDuaCategories() async {
    // await initDb();
    database = await openDb();
    var duaCategoryList = <RuqyahCategory>[];
    var cursor = await database!.query(_rduaCatergoryTable);
    for (var maps in cursor) {
      var duaCategory = RuqyahCategory.fromJson(maps);
      duaCategoryList.add(duaCategory);
    }
    return duaCategoryList;
  }

  // initDb() async {
  //   database = await openDatabase('assets/fullquran.db');
  //   var dbPath = await getDatabasesPath();
  //   var path = join(dbPath, 'fullquran.db');
  //   // Check if Db Exists
  //   var exists = await databaseExists(path);
  //   if(!exists) {
  //     // print('not exist');
  //     try{
  //       await Directory(dirname(path)).create(recursive:true);
  //     }catch(_){}
  //     // copy form assets folder
  //     ByteData data = await rootBundle.load(join('assets','fullquran.db'));
  //     List<int> bytes = data.buffer.asUint8List(data.offsetInBytes,data.lengthInBytes);
  //
  //     // write and flush the bytes
  //     await File(path).writeAsBytes(bytes,flush: true);
  //   }else{
  //     // print('exist');
  //     // Get the current version of the database from the assets folder
  //     ByteData data = await rootBundle.load(join('assets', 'fullquran.db'));
  //     List<int> currentDbBytes = data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
  //     // Get the existing version of the database from the device
  //     List<int> existingDbBytes = await File(path).readAsBytes();
  //     // Compare the versions
  //     if (!listEquals(existingDbBytes, currentDbBytes)) {
  //       // print('different');
  //       // Write the current version of the database to the device
  //       await File(path).writeAsBytes(currentDbBytes, flush: true).then((value) {
  //         List bookmarksList = Hive.box('myBox').get('bookmarks') ?? [];
  //         if(bookmarksList.isNotEmpty){
  //           for(int i=0;i<bookmarksList.length;i++){
  //             Bookmarks bookmarks = bookmarksList[i];
  //             addBookmark(bookmarks.surahId!, bookmarks.verseId!);
  //           }
  //         }
  //       });
  //     }
  //   }
  //   // open db
  //   database = await openDatabase(path);
  // }

// Initialize and save the database file in the documents directory
  Future<void> initAndSaveDb() async {
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
      await File(path).writeAsBytes(bytes, flush: true).then((value) async {
        List bookmarkList = [
          Bookmarks(
              surahId: 36,
              verseId: 1,
              surahName: "Ya-seen",
              surahArabic: "يس",
              juzId: 23,
              juzName: "",
              isFromJuz: false,
              bookmarkPosition: 1),
          Bookmarks(
              surahId: 18,
              verseId: 1,
              surahName: "Al-Kahf",
              surahArabic: "الكهف",
              juzId: 15,
              juzName: "",
              isFromJuz: false,
              bookmarkPosition: 1),
        ];
        Hive.box("myBox").put("bookmarks", bookmarkList);
        List duaBookmarkList = [
          BookmarksDua(
            duaId: 45,
            duaNo: 1,
            categoryId: 2,
            categoryName: "Prayers_to_Start_Your_Day",
            duaTitle: "Dua 1",
            duaRef: "Al-Baqara: 255",
            ayahCount: 1,
            duaText:
                '''اللَّهُ لَا إِلَٰهَ إِلَّا هُوَ الْحَيُّ الْقَيُّومُ ۚ لَا تَأْخُذُهُ سِنَةٌ وَلَا نَوْمٌ ۚ لَّهُ مَا فِي السَّمَاوَاتِ وَمَا فِي الْأَرْضِ ۗ مَن ذَا الَّذِي يَشْفَعُ عِندَهُ إِلَّا بِإِذْنِهِ ۚ يَعْلَمُ مَا بَيْنَ أَيْدِيهِمْ وَمَا خَلْفَهُمْ ۖ وَلَا يُحِيطُونَ بِشَيْءٍ مِّنْ عِلْمِهِ إِلَّا بِمَا شَاءَ ۚ وَسِعَ كُرْسِيُّهُ السَّمَاوَاتِ وَالْأَرْضَ ۖ وَلَا يَئُودُهُ حِفْظُهُمَا ۚ وَهُوَ الْعَلِيُّ الْعَظِيمُ ‎﴿٢٥٥﴾''',
            duaTranslation:
                '''Allah - there is no deity except Him, the Ever-Living, the Sustainer of [all] existence. Neither drowsiness overtakes Him nor sleep. To Him belongs whatever is in the heavens and whatever is on the earth. Who is it that can intercede with Him except by His permission? He knows what is [presently] before them and what will be after them, and they encompass not a thing of His knowledge except for what He wills. His Kursi extends over the heavens and the earth, and their preservation tires Him not. And He is the Most High, the Most Great.''',
            bookmarkPosition: 1,
            duaUrl:
                "https://bucketsawstest.s3.us-west-1.amazonaws.com/Duas/Prayers_to_Start_Your_Day/Dua_1.mp3",
          ),
          BookmarksDua(
            duaId: 86,
            duaNo: 8,
            categoryId: 5,
            categoryName: "Influential_Duas_for_Ruqyah",
            duaTitle: "Dua 8",
            duaRef: "Surah Al-Baqarah, verses 285-286",
            ayahCount: 2,
            duaText:
                '''آمَنَ الرَّسُولُ بِمَا أُنزِلَ إِلَيْهِ مِن رَّبِّهِ وَالْمُؤْمِنُونَ ۚ كُلٌّ آمَنَ بِاللَّهِ وَمَلَائِكَتِهِ وَكُتُبِهِ وَرُسُلِهِ لَا نُفَرِّقُ بَيْنَ أَحَدٍ مِّن رُّسُلِهِ ۚ وَقَالُوا سَمِعْنَا وَأَطَعْنَا ۖ غُفْرَانَكَ رَبَّنَا وَإِلَيْكَ الْمَصِيرُ ‎﴿٢٨٥﴾‏ لَا يُكَلِّفُ اللَّهُ نَفْسًا إِلَّا وُسْعَهَا ۚ لَهَا مَا كَسَبَتْ وَعَلَيْهَا مَا اكْتَسَبَتْ ۗ رَبَّنَا لَا تُؤَاخِذْنَا إِن نَّسِينَا أَوْ أَخْطَأْنَا ۚ رَبَّنَا وَلَا تَحْمِلْ عَلَيْنَا إِصْرًا كَمَا حَمَلْتَهُ عَلَى الَّذِينَ مِن قَبْلِنَا ۚ رَبَّنَا وَلَا تُحَمِّلْنَا مَا لَا طَاقَةَ لَنَا بِهِ ۖ وَاعْفُ عَنَّا وَاغْفِرْ لَنَا وَارْحَمْنَا ۚ أَنتَ مَوْلَانَا فَانصُرْنَا عَلَى الْقَوْمِ الْكَافِرِينَ ‎﴿٢٨٦﴾‏''',
            duaTranslation: '''<p>
The Prophet believes in what has been revealed to him by his Lord, and so do the faithful. Each one believes in God and His angels, His Books and the prophets, and We make no distinction between the apostles. For they say: "We hear and obey, and we seek Your forgiveness, O Lord, for to You we shall journey in the end." (285) 
</p>
<p>
God does not burden a soul beyond capacity. Each will enjoy what (good) he earns, as indeed each will suffer from (the wrong) he does. Punish us not, O Lord, if we fail to remember or lapse into error. Burden us not, O Lord, with a burden as You did those before us. Impose not upon us a burden, O Lord, we cannot carry. Overlook our trespasses and forgive us, and have mercy upon us; You are our Lord and Master, help us against the clan of unbelievers. (286)
</p>''',
            bookmarkPosition: 1,
            duaUrl:
                "https://bucketsawstest.s3.us-west-1.amazonaws.com/Duas/Influential_Duas_for_Ruqyah/Dua_8.mp3",
          ),
          BookmarksDua(
            duaId: 95,
            duaNo: 1,
            categoryId: 6,
            categoryName: "Bedtime_Prayers",
            duaTitle: "Dua 1",
            duaRef: "Surah Al-Kafirun",
            ayahCount: 6,
            duaText: '''بِسْمِ اللَّهِ الرَّحْمَٰنِ الرَّحِيمِ

قُلْ يَا أَيُّهَا الْكَافِرُونَ ‎﴿١﴾‏ لَا أَعْبُدُ مَا تَعْبُدُونَ ‎﴿٢﴾‏ وَلَا أَنتُمْ عَابِدُونَ مَا أَعْبُدُ ‎﴿٣﴾‏ وَلَا أَنَا عَابِدٌ مَّا عَبَدتُّمْ ‎﴿٤﴾‏ وَلَا أَنتُمْ عَابِدُونَ مَا أَعْبُدُ ‎﴿٥﴾‏ لَكُمْ دِينُكُمْ وَلِيَ دِينِ ‎﴿٦﴾‏''',
            duaTranslation:
                '''SAY: "O YOU unbelievers, (1) I do not worship what you worship, (2) Nor do you worship who I worship, (3) Nor will I worship what you worship, (4) Nor will you worship who I worship: (5) To you your way, to me my way (6)''',
            bookmarkPosition: 1,
            duaUrl:
                "https://bucketsawstest.s3.us-west-1.amazonaws.com/Duas/Bedtime_Prayers/Dua_1.mp3",
          ),
        ];
        Hive.box("myBox").put("bookmarks1", duaBookmarkList);
        List ruqyahbookmark = [
          BookmarksRuqyah(
            duaId: 4,
            duaNo: 1,
            categoryId: 4,
            categoryName: "The protection against black magic and evil eye",
            duaTitle: "Dua 1",
            duaRef: "Al Kafiroon, Al Ikhlaas, Al Falak, An Nas.",
            ayahCount: 15,
            duaText: '''بِسْمِ اللَّهِ الرَّحْمَٰنِ الرَّحِيمِ
قُلْ يَا أَيُّهَا الْكَافِرُونَ ‎﴿١﴾‏ لَا أَعْبُدُ مَا تَعْبُدُونَ ‎﴿٢﴾‏ وَلَا أَنتُمْ عَابِدُونَ مَا أَعْبُدُ ‎﴿٣﴾‏ وَلَا أَنَا عَابِدٌ مَّا عَبَدتُّمْ ‎﴿٤﴾‏ وَلَا أَنتُمْ عَابِدُونَ مَا أَعْبُدُ ‎﴿٥﴾‏ لَكُمْ دِينُكُمْ وَلِيَ دِينِ ‎﴿٦﴾‏

بِسْمِ اللَّهِ الرَّحْمَٰنِ الرَّحِيمِ
قُلْ هُوَ اللَّهُ أَحَدٌ ‎﴿١﴾‏ اللَّهُ الصَّمَدُ ‎﴿٢﴾‏ لَمْ يَلِدْ وَلَمْ يُولَدْ ‎﴿٣﴾‏ وَلَمْ يَكُن لَّهُ كُفُوًا أَحَدٌ ‎﴿٤﴾‏

بِسْمِ اللَّهِ الرَّحْمَٰنِ الرَّحِيمِ
قُلْ أَعُوذُ بِرَبِّ الْفَلَقِ ‎﴿١﴾‏ مِن شَرِّ مَا خَلَقَ ‎﴿٢﴾‏ وَمِن شَرِّ غَاسِقٍ إِذَا وَقَبَ ‎﴿٣﴾‏ وَمِن شَرِّ النَّفَّاثَاتِ فِي الْعُقَدِ ‎﴿٤﴾‏ وَمِن شَرِّ حَاسِدٍ إِذَا حَسَدَ ‎﴿٥﴾‏

بِسْمِ اللَّهِ الرَّحْمَٰنِ الرَّحِيمِ
قُلْ أَعُوذُ بِرَبِّ النَّاسِ ‎﴿١﴾‏ مَلِكِ النَّاسِ ‎﴿٢﴾‏ إِلَٰهِ النَّاسِ ‎﴿٣﴾‏ مِن شَرِّ الْوَسْوَاسِ الْخَنَّاسِ ‎﴿٤﴾‏ الَّذِي يُوَسْوِسُ فِي صُدُورِ النَّاسِ ‎﴿٥﴾‏ مِنَ الْجِنَّةِ وَالنَّاسِ ‎﴿٦﴾‏''',
            duaTranslation: '''1. Al Kafiroon
Say, "O disbelievers, (1) I do not worship what you worship. (2) Nor are you
    worshippers of what I worship. (3) Nor will I be a worshipper of what you
    worship. (4) Nor will you be worshippers of what I worship. (5) For you is
    your religion, and for me is my religion." (6)

2. Al Ikhlaas
Say, "He is Allah, [who is] One, (1) Allah, the Eternal Refuge. (2) He
    neither begets nor is born, (3) Nor is there to Him any equivalent." (4)
  
3. Al Falak
Say, "I seek refuge in the Lord of daybreak (1) From the evil of that which
    He created (2) And from the evil of darkness when it settles (3) And from
    the evil of the blowers in knots (4) And from the evil of an envier when he
    envies." (5)

4. An Nas
Say, "I seek refuge in the Lord of mankind, (1) The Sovereign of mankind.
    (2) The God of mankind, (3) From the evil of the retreating whisperer - (4)
    Who whispers [evil] into the breasts of mankind - (5) From among the jinn
    and mankind." (6)''',
            bookmarkPosition: 1,
            duaUrl:
                "https://bucketsawstest.s3.us-west-1.amazonaws.com/al_ruqyah/The_protection_against_black_magic_and_evil_eye/dua_1.mp3",
          ),
        ];
        Hive.box("myBox").put("bookmarks2", ruqyahbookmark);
      });
      print('Database file copied to documents directory');
    } else {
      print('Database file already exists in documents directory');
    }
  }

// Open the database
  Future<Database> openDb() async {
    var dbPath = await getDatabasesPath();
    var path = join(dbPath, 'masterdb.db');
    return await openDatabase(path, readOnly: false);
  }

  // to load all quran text
  Future<List<QuranText>> getQuranSurahText({required int surahId}) async {
    database = await openDb();
    var quranTextList = <QuranText>[];
    var table = await database!.query(_quranTextTable,
        where: "surah_id= ?", whereArgs: [surahId], orderBy: "verse_id");
    for (var rows in table) {
      var ayahText = QuranText.fromJson(rows);
      quranTextList.add(ayahText);
    }
    return quranTextList;
  }

  // to load all quran text
  Future<List<QuranText>> getQuranJuzText({required int juzId}) async {
    database = await openDb();
    var quranTextList = <QuranText>[];
    var table = await database!.query(_quranTextTable,
        where: "juz_id= ?", whereArgs: [juzId], orderBy: "surah_id, verse_id");
    // print(table);
    for (var rows in table) {
      var ayahText = QuranText.fromJson(rows);
      quranTextList.add(ayahText);
    }
    return quranTextList;
  }

  // get verse of the day
  Future<QuranText?> getVerseOfTheDay() async {
    var quranTextList = <QuranText>[];
    database = await openDb();
    var rows = await database!.query(
      'quran_text',
      where: 'verse_of_the_day = ?',
      whereArgs: ['yes'],
      orderBy: 'RANDOM()',
      limit: 1,
    );
    for (var row in rows) {
      var ayahText = QuranText.fromJson(row);
      quranTextList.add(ayahText);
    }
    if (quranTextList.isNotEmpty) {
      return quranTextList.first;
    } else {
      return null;
    }
  }

  Future<QuranText> getVerse(QuranText quranText) async {
    QuranText quranVerse = quranText;
    database = await openDb();
    var table = await database!.rawQuery(
        "select * from $_quranTextTable where surah_id = ${quranText.surahId} and verse_id = ${quranText.verseId}");
    for (var rows in table) {
      quranVerse = QuranText.fromJson(rows);
    }
    return quranVerse;
  }

  // to load all surah names
  Future<List<Surah>> getSurahName() async {
    database = await openDb();
    var surahList = <Surah>[];
    var cursor = await database!.query(_surahNameTable);
    for (var maps in cursor) {
      var surahNames = Surah.fromJson(maps);
      surahList.add(surahNames);
    }
    return surahList;
  }

  Future<Surah?> getSurahByName(String surahName) async {
    database = await openDb();
    var cursor = await database!.query(_surahNameTable,
        where: 'surah_name = ?', whereArgs: [surahName], limit: 1);
    if (cursor.isNotEmpty) {
      return Surah.fromJson(cursor.first);
    } else {
      return null;
    }
  }

  // to load all surah names
  Future<Surah?> getSpecificSurahName(int surahId) async {
    database = await openDb();
    var cursor = await database!
        .query(_surahNameTable, where: "Id=?", whereArgs: [surahId]);
    for (var maps in cursor) {
      return Surah.fromJson(maps);
    }
    return null;
  }

  // to load all duas category names
  Future<List<DuaCategory>> getDuaCategories() async {
    // await initDb();
    database = await openDb();
    var duaCategoryList = <DuaCategory>[];
    var cursor = await database!.query(_duaCategoryTable);
    for (var maps in cursor) {
      var duaCategory = DuaCategory.fromJson(maps);
      duaCategoryList.add(duaCategory);
    }
    return duaCategoryList;
  }

  // to load all duas category names
  Future<List<Dua>> getDua(int categoryId) async {
    database = await openDb();
    var duaList = <Dua>[];
    var cursor = await database!.query(_duaAllTable,
        where: "category_id = ? AND status = 'active'",
        whereArgs: [categoryId]);
    for (var maps in cursor) {
      var dua = Dua.fromJson(maps);
      duaList.add(dua);
    }
    return duaList;
  }

  // to load all the duas in the table
  Future<List<Dua>> getallDua() async {
    database = await openDb();
    var duaList = <Dua>[];
    var cursor = await database!.query(_duaAllTable);
    for (var maps in cursor) {
      var dua = Dua.fromJson(maps);
      duaList.add(dua);
    }
    return duaList;
  }

  // to load all Reciter names
  Future<List<Reciters>> getReciter() async {
    // await initDb();
    database = await openDb();
    var reciterList = <Reciters>[];
    var cursor = await database!.query(_reciterTable);
    for (var maps in cursor) {
      var reciter = Reciters.fromJson(maps);
      reciterList.add(reciter);
    }
    return reciterList;
  }

  Future<void> updateReciterIsFav(int reciterId, int value) async {
    database = await openDb();
    await database!.execute(
        "update $_reciterTable set is_fav = $value where reciter_id = $reciterId");
  }

  Future<List<Reciters>> getFavReciters() async {
    database = await openDb();
    List<Reciters> reciters = [];
    var table = await database!
        .query(_reciterTable, where: "is_fav = ?", whereArgs: [1]);
    for (var map in table) {
      reciters.add(Reciters.fromJson(map));
    }
    return reciters;
  }

  Future<void> updateReciterDownloadList(
      int reciterId, Reciters reciters) async {
    database = await openDb();
    await database!.update(_reciterTable, reciters.toJson(),
        where: "reciter_id = ?", whereArgs: [reciterId]);
  }

  // for bismillah
  Future<void> updateBissmillahOfEachTranslation(
      String text, String translationName) async {
    database = await openDb();
    await database!.transaction((txn) async {
      await txn.rawUpdate(
        "update $_quranTextTable set $translationName = ? where verse_id = ?",
        [text, 0],
      );
    });
  }

  // Future<void> updateQuranTranslations(List translations,String translationName,BuildContext context,int index) async {
  //   database = await openDb();
  //   await database!.transaction((txn) async {
  //     Batch batch1 = txn.batch();
  //     for(int k = 0; k < translations.length; k++){
  //       batch1.rawUpdate(
  //           "update $_quranTextTable set $translationName = ? where surah_id = ? and verse_id = ?",
  //           [translations[k][2], int.parse(translations[k][0]), int.parse(translations[k][1])]
  //       );
  //     }
  //     await batch1.commit().then((value) =>print("done1"));
  //     Future.delayed(Duration.zero,()=>context.read<TranslationManagerProvider>().updateState(index, context));
  //   });
  // }

  Future<void> updateQuranTranslations(List translations,
      String translationName, BuildContext context, int index) async {
    database = await openDb();

    // create indexes on surah_id and verse_id columns
    await database!.execute(
        "CREATE INDEX IF NOT EXISTS surah_id_idx ON $_quranTextTable (surah_id)");
    await database!.execute(
        "CREATE INDEX IF NOT EXISTS verse_id_idx ON $_quranTextTable (verse_id)");

    await database!.transaction((txn) async {
      for (int k = 0; k < translations.length; k++) {
        await txn.execute(
          "update $_quranTextTable set $translationName = ? where surah_id = ? and verse_id = ?",
          [
            translations[k][2],
            int.parse(translations[k][0]),
            int.parse(translations[k][1])
          ],
        );
      }
    }).then((value) {
      Future.delayed(
          Duration.zero,
          () => context
              .read<TranslationManagerProvider>()
              .updateState(index, context));
    });
  }

  Future<void> addNew(List translations, String translationName) async {
    database = await openDb();
    await database!.transaction((txn) async {
      for (int k = 0; k < translations.length; k++) {
        trans transa = trans(int.parse(translations[k][0]),
            int.parse(translations[k][1]), translations[k][2]);
        await txn.insert('testing', transa.toJson());
        print(k);
      }
    });
  }

  // to load all Para Name
  Future<List<Juz>> getJuzNames() async {
    // await initDb();
    database = await openDb();
    var juzList = <Juz>[];
    var cursor = await database!.query(_juzListTable);
    for (var result in cursor) {
      var data = Juz.fromJson(result);
      juzList.add(data);
    }
    return juzList;
  }

  Future<List<QuranText>> getJuzIds() async {
    database = await openDb();
    List<QuranText> juzIds = [];
    var cursor = await database!.query(_quranTextTable);
    for (var ids in cursor) {
      var data = QuranText.fromJson(ids);
      juzIds.add(data);
    }
    return juzIds;
  }

  //add a bookmark
  void addBookmark(int surahId, int verseId) async {
    database = await openDb();
    await database!.rawUpdate(
        "update $_quranTextTable set is_bookmark = 1 where surah_id = $surahId AND verse_id = $verseId");
  }

  //delete bookmark
  void removeBookmark(int surahId, int verseId) async {
    database = await openDb();
    await database!.rawUpdate(
        "update $_quranTextTable set is_bookmark = 0 where surah_id = $surahId AND verse_id = $verseId");
  }

  Future<List<QuranText>> getBookmarks() async {
    database = await openDb();
    List<QuranText> quranTextList = [];
    var table = await database!
        .query(_quranTextTable, where: "is_bookmark= ?", whereArgs: [1]);
    for (var rows in table) {
      var ayahText = QuranText.fromJson(rows);
      quranTextList.add(ayahText);
    }
    return quranTextList;
  }

  //________________________________________________
  //                  DUA BOOKMARKS
  //add a bookmark
  void adduaBookmark(int duaId) async {
    database = await openDb();
    await database!
        .rawUpdate("update $_duaAllTable set is_fav = 1 where dua_id = $duaId");
    //   print('QuranDatabase :::::             added    DuaID is: $duaId');
  }

  //delete bookmark
  void removeduaBookmark(int duaId, int categoryId) async {
    database = await openDb();
    await database!.rawUpdate(
        "update $_duaAllTable set is_fav = 0 where dua_id = $duaId AND category_id = $categoryId");
    // print(
    //     'QuranDatabase :::::            removed     DuaID is: $duaId DuaCat is: $categoryId');
  }

  Future<List<Dua>> getduaBookmarks() async {
    database = await openDb();
    List<Dua> quranTextList = [];
    var table =
        await database!.query(_duaAllTable, where: "is_fav= ?", whereArgs: [1]);
    for (var rows in table) {
      var ayahText = Dua.fromJson(rows);
      quranTextList.add(ayahText);
    }
    return quranTextList;
  }

  //                 Ruqyah Dua BOOKMARKS
  //add a bookmark
  void addRBookmark(int duaId) async {
    database = await openDb();
    await database!.rawUpdate(
        "update $_rduaAllTable set is_fav = 1 where ruqyah_id = $duaId");
    //print('DuaID is: $duaId');
  }

  //delete bookmark
  void removeRduaBookmark(int duaId, int rCategory) async {
    database = await openDb();
    await database!.rawUpdate(
        "update $_rduaAllTable set is_fav = 0 where ruqyah_id = $duaId AND category_id = $rCategory ");
    // print('DuaID removed is: $duaId');
    // print(
    //     'QuranDatabase :::::            removed     DuaID is: $duaId DuaCat is: $rCategory');
  }

  Future<List<Ruqyah>> getRduaBookmarks() async {
    database = await openDb();
    List<Ruqyah> quranTextList = [];
    var table = await database!
        .query(_rduaAllTable, where: "is_fav= ?", whereArgs: [1]);
    for (var rows in table) {
      var ayahText = Ruqyah.fromJson(rows);
      quranTextList.add(ayahText);
    }
    return quranTextList;
  }

  // List<String> words = normalizedText.trim().split(RegExp(r'\s+'));

  // Future<List<QuranText>> searchQuranText(String searchTerm) async {
  //   // Remove Tajweedi marks from the Arabic text
  //   database = await openDb();
  //   List<QuranText> fullQuranText = [];
  //   var table = await database!.query(_quranTextTable);
  //   for (var map in table) {
  //     fullQuranText.add(QuranText.fromJson(map));
  //   }
  //
  //   // Filter the Quran text based on the search term
  //   List<QuranText> filteredQuranText = [];
  //   if (fullQuranText.isNotEmpty) {
  //     for (var quranText in fullQuranText) {
  //       String verseText = quranText.verseText!;
  //       String normalizedText = verseText.replaceAll(RegExp(r'[\u0610-\u061A\u064B-\u065F\u0670\u06D6-\u06ED]'), '');
  //       List<String> words = normalizedText.trim().split(RegExp(r'\s+'));
  //
  //       // Check if the search term matches any word in the verse text
  //       for (var word in words) {
  //         if (word.contains(searchTerm)) {
  //           // Highlight the matching search term in the verse text
  //           // String highlightedText = verseText.replaceAll(searchTerm, '<b>$searchTerm</b>');
  //           QuranText filtered = QuranText(surahId: quranText.surahId!, verseId: quranText.verseId, verseText: quranText.verseText, translationText: quranText.translationText, isBookmark: quranText.isBookmark);
  //           filteredQuranText.add(filtered);
  //           break;
  //         }else{
  //           filteredQuranText = [];
  //         }
  //       }
  //     }
  //   }
  //   return filteredQuranText;
  // }

  // do searching in quran
  // Future<List<QuranText>> searchQuranText(String word) async{
  //   // Remove Tajweedi marks from the Arabic text
  //   database = await openDb();
  //   List<QuranText> fullQuranText = [];
  //   List<QuranText> filteredQuranText = [];
  //   var table = await database!.query(_quranTextTable);
  //   for(var map in table){
  //     fullQuranText.add(QuranText.fromJson(map));
  //   }
  //   if(fullQuranText.isNotEmpty){
  //     for(var quranText in fullQuranText){
  //       String normalizedText = quranText.verseText!.replaceAll(RegExp(r'[\u0610-\u061A\u064B-\u065F\u0670\u06D6-\u06ED]'), '');
  //
  //     }
  //   }
  //   return filteredQuranText;
  // }
}

class trans {
  int surahId;
  int id2;
  String text;

  trans(this.surahId, this.id2, this.text);

  Map<String, Object?> toJson() {
    return {"surahId": surahId, "verseId": id2, "text": text};
  }
}
