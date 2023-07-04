import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:nour_al_quran/pages/duas/dua_provider.dart';
import 'package:nour_al_quran/pages/quran/pages/recitation/reciter/player/player_provider.dart';
import 'package:nour_al_quran/shared/database/quran_db.dart';
import 'package:provider/provider.dart';

import '../../shared/entities/bookmarks_dua.dart';
import 'dua_detailed.dart';

class BookmarkProviderDua extends ChangeNotifier {
  final List _bookmarkList = Hive.box('myBox').get('bookmarks1') ?? [];
  List get bookmarkList => _bookmarkList;

  void removeBookmark(int duaId, int categoryId) {
    QuranDatabase().removeduaBookmark(duaId, categoryId);
    _bookmarkList.removeWhere((element) =>
        element.duaId == duaId && element.categoryId == categoryId);
    notifyListeners();
    Hive.box("myBox").put("bookmarks1", _bookmarkList);
  }

  void addBookmark(BookmarksDua bookmarks) {
    QuranDatabase().adduaBookmark(bookmarks.duaId!);
    if (!_bookmarkList.contains(bookmarks)) {
      _bookmarkList.add(bookmarks);
    }
    notifyListeners();
    Hive.box("myBox").put("bookmarks1", _bookmarkList);
  }

  void goToAudioPlayer(BookmarksDua bookmarks, BuildContext context) async {
    // context.read<QuranProvider>().setJuzText(
    //     juzId: bookmarks.juzId!,
    //     title: bookmarks.juzName!,
    //     fromWhere: 2,
    //     isJuz: true,
    //     bookmarkPosition: bookmarks.bookmarkPosition);

    Provider.of<DuaProvider>(context, listen: false);

    /// if recitation player is on So this line is used to pause the player
    Future.delayed(Duration.zero,
        () => context.read<RecitationPlayerProvider>().pause(context));
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) {
        return const DuaDetail();
      },
    ));
  }
}

// Navigator.of(context).pushNamed(
//                             RouteHelper.duaDetailed,
//                           );
//                           duaProvider.gotoDuaPlayerPage(dua.id!, context);