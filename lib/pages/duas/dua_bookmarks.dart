import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nour_al_quran/pages/duas/dua_bookmarks_provider.dart';
import 'package:nour_al_quran/pages/duas/dua_provider.dart';
import 'package:nour_al_quran/pages/duas/widgets/ruqyah_bookmark_provider.dart';
import 'package:nour_al_quran/pages/quran/pages/ruqyah/models/ruqyah_provider.dart';
import 'package:nour_al_quran/pages/quran/widgets/details_container_widget.dart';
import 'package:nour_al_quran/shared/localization/localization_constants.dart';
import 'package:provider/provider.dart';
import '../../shared/routes/routes_helper.dart';

class DuaBookmarkPage extends StatelessWidget {
  const DuaBookmarkPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
            margin: EdgeInsets.only(
                bottom: 10.h, left: 20.h, top: 2.h, right: 20.w),
            child: Text(
              localeText(context, "dua_bookmarks"),
              style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold),
            )),
        Expanded(
          child: Consumer2<BookmarkProviderDua, BookmarkProviderRuqyah>(
            builder: (context, bookmarkDuaValue, bookmarkRuqyahValue, child) {
              final bookmarkListDua = bookmarkDuaValue.bookmarkList;
              final bookmarkListRuqyah = bookmarkRuqyahValue.bookmarkList;

              final combinedBookmarkList = [
                ...bookmarkListDua,
                ...bookmarkListRuqyah
              ];

              return combinedBookmarkList.isNotEmpty
                  ? ListView.builder(
                      shrinkWrap: true,
                      itemCount: combinedBookmarkList.length,
                      itemBuilder: (context, index) {
                        final bookmark = combinedBookmarkList[index];
                        final isDuaBookmark = index < bookmarkListDua.length;

                        return InkWell(
                          onTap: () async {
                            if (isDuaBookmark) {
                              Provider.of<DuaProvider>(context, listen: false)
                                  .gotoDuaPlayerPage(
                                bookmark.categoryId!,
                                bookmark.duaText!,
                                context,
                              );
                              Navigator.of(context).pushNamed(
                                RouteHelper.duaDetailed,
                              );
                            } else {
                              Provider.of<RuqyahProvider>(context,
                                      listen: false)
                                  .gotoDuaPlayerPage(
                                bookmark.categoryId!,
                                bookmark.duaText!,
                                context,
                              );
                              Navigator.of(context).pushNamed(
                                RouteHelper.ruqyahDetailed,
                              );
                            }
                          },
                          child: DetailsContainerWidget(
                            title:
                                '${bookmark.duaTitle} - ${localeText(context, bookmark.categoryName!)}',
                            subTitle:
                                "${localeText(context, "dua")} ${bookmark.duaNo} , ${bookmark.duaRef}",
                            icon: Icons.bookmark,
                            onTapIcon: () {
                              if (isDuaBookmark) {
                                bookmarkDuaValue.removeBookmark(
                                    bookmark.duaId!, bookmark.categoryId!);
                              } else {
                                bookmarkRuqyahValue.removeBookmark(
                                    bookmark.duaId!, bookmark.categoryId!);
                              }
                            },
                          ),
                        );
                      },
                    )
                  : const Text('');
            },
          ),
        ),
      ],
    );
  }
}
