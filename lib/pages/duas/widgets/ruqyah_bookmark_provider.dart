import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:nour_al_quran/pages/quran/pages/recitation/reciter/player/player_provider.dart';
import 'package:nour_al_quran/shared/database/quran_db.dart';
import 'package:provider/provider.dart';

import '../../../shared/entities/bookmarks_ruqyah.dart';
import '../../quran/pages/ruqyah/models/ruqyah_provider.dart';
import '../../quran/pages/ruqyah/ruqyah_detailed.dart';

class BookmarkProviderRuqyah extends ChangeNotifier {
  final List _bookmarkList = Hive.box('myBox').get('bookmarks2') ?? [];
  List get bookmarkList => _bookmarkList;

  void removeBookmark(int duaId, int categoryId) {
    QuranDatabase().removeRduaBookmark(duaId, categoryId);
    _bookmarkList.removeWhere((element) =>
        element.duaId == duaId && element.categoryId == categoryId);
    notifyListeners();
    Hive.box("myBox").put("bookmarks2", _bookmarkList);
  }

  void addBookmark(BookmarksRuqyah bookmarks) {
    QuranDatabase().addRBookmark(bookmarks.duaId!);
    if (!_bookmarkList.contains(bookmarks)) {
      _bookmarkList.add(bookmarks);
    }
    notifyListeners();
    Hive.box("myBox").put("bookmarks2", _bookmarkList);
  }

  void goToAudioPlayer(BookmarksRuqyah bookmarks, BuildContext context) async {
    // context.read<QuranProvider>().setJuzText(
    //     juzId: bookmarks.juzId!,
    //     title: bookmarks.juzName!,
    //     fromWhere: 2,
    //     isJuz: true,
    //     bookmarkPosition: bookmarks.bookmarkPosition);

    Provider.of<RuqyahProvider>(context, listen: false);

    /// if recitation player is on So this line is used to pause the player
    Future.delayed(Duration.zero,
        () => context.read<RecitationPlayerProvider>().pause(context));
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) {
        return const RuqyahDetail();
      },
    ));
  }
}

// Navigator.of(context).pushNamed(
//                             RouteHelper.duaDetailed,
//                           );
//                           duaProvider.gotoDuaPlayerPage(dua.id!, context);