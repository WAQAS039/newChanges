import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:nour_al_quran/pages/quran/pages/recitation/reciter/player/player_provider.dart';
import 'package:nour_al_quran/pages/quran/providers/quran_provider.dart';
import 'package:nour_al_quran/pages/quran/widgets/quran_text_view.dart';
import 'package:nour_al_quran/shared/database/quran_db.dart';
import 'package:nour_al_quran/shared/entities/bookmarks.dart';
import 'package:provider/provider.dart';

class BookmarkProvider extends ChangeNotifier{
  final List _bookmarkList =  Hive.box('myBox').get('bookmarks') ?? [];
  List get bookmarkList => _bookmarkList;

  void removeBookmark(int surahId,int verseId){
    QuranDatabase().removeBookmark(surahId, verseId);
    // print(_bookmarkList.indexWhere((element) => element.surahId == surahId && element.verseId == verseId));
    _bookmarkList.removeWhere((element) => element.surahId == surahId && element.verseId == verseId);
    notifyListeners();
    Hive.box("myBox").put("bookmarks", _bookmarkList);
  }

  void addBookmark(Bookmarks bookmarks){
    QuranDatabase().addBookmark(bookmarks.surahId!, bookmarks.verseId!);
    _bookmarkList.add(bookmarks);
    notifyListeners();
    Hive.box("myBox").put("bookmarks", _bookmarkList);
  }

  void goToQuranView(Bookmarks bookmarks, BuildContext context) async{
    if(bookmarks.isFromJuz!){
      context.read<QuranProvider>().setJuzText(juzId: bookmarks.juzId!,title: bookmarks.juzName!,fromWhere: 2,isJuz: true,bookmarkPosition: bookmarks.bookmarkPosition);
      /// if recitation player is on So this line is used to pause the player
      Future.delayed(Duration.zero,()=>context.read<RecitationPlayerProvider>().pause(context));
      Navigator.of(context).push(MaterialPageRoute(builder: (context) {
        return const QuranTextView();
      },));
    }else{
      // coming from surah so isJuz already false
      // coming from surah so JuzId already -1
      context.read<QuranProvider>().setSurahText(surahId: bookmarks.surahId!,title:'سورة ${bookmarks.surahArabic}',fromWhere: 2,bookmarkPosition: bookmarks.bookmarkPosition);
      /// if recitation player is on So this line is used to pause the player
      Future.delayed(Duration.zero,()=>context.read<RecitationPlayerProvider>().pause(context));
      Navigator.of(context).push(MaterialPageRoute(builder: (context) {
        return const QuranTextView();
      },));
    }
  }
}