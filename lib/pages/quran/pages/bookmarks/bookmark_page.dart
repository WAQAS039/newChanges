import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nour_al_quran/pages/quran/pages/bookmarks/bookmarks_provider.dart';
import 'package:nour_al_quran/pages/quran/widgets/details_container_widget.dart';
import 'package:nour_al_quran/shared/entities/bookmarks.dart';
import 'package:nour_al_quran/shared/localization/localization_constants.dart';
import 'package:nour_al_quran/shared/localization/localization_provider.dart';
import 'package:provider/provider.dart';

class BookmarkPage extends StatelessWidget {
  const BookmarkPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
            margin: EdgeInsets.only(bottom: 10.h,left: 20.h,top: 2.h,right: 20.w),
            child: Text(localeText(context, "reading_bookmarks"),style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.bold
            ),)),
        Consumer<BookmarkProvider>(
          builder: (context, bookmarkValue, child) {
            return bookmarkValue.bookmarkList.isNotEmpty ? Expanded(
              child: MediaQuery.removePadding(
                context: context,
                removeTop: true,
                child: ListView.builder(
                  itemCount: bookmarkValue.bookmarkList.length,
                  itemBuilder: (context, index) {
                    Bookmarks bookmarks = bookmarkValue.bookmarkList[index];
                    return InkWell(
                      onTap: () async{
                        bookmarkValue.goToQuranView(bookmarks, context);
                      },
                      child: DetailsContainerWidget(
                        title: LocalizationProvider().checkIsArOrUr() ? bookmarks.surahArabic! :bookmarks.surahName!,
                        subTitle: "${localeText(context, "surah")} ${bookmarks.surahId} , ${localeText(context, "ayat")} ${bookmarks.verseId}",
                        icon: Icons.bookmark,
                        onTapIcon: (){
                          bookmarkValue.removeBookmark(bookmarks.surahId!,bookmarks.verseId!);
                        },),
                    );
                  },),
              ),
            ) : Expanded(child: Center(child: Text(localeText(context,"no_bookmarks_added_yet")),));
          },
        )
      ],
    );
  }
}


// const SubTitleText(title: "Audio Bookmarks"),
// DetailsContainerWidget(title: 'Surah ${surah[1-1].surahName}',subTitle: "${surah[1-1].englishName}, Surah # ${surah[1-1].surahId}",icon: Icons.bookmark,onTapIcon: (){},),
// DetailsContainerWidget(title: 'Surah Al-Fatihah',subTitle: "The Opener, Surah # 1",icon: Icons.bookmark,onTapIcon: (){},),