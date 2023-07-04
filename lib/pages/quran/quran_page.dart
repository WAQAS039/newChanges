import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nour_al_quran/pages/quran/pages/bookmarks/bookmark_page.dart';
//import 'package:nour_al_quran/pages/quran/pages/duas/dua_categories_page.dart';
import 'package:nour_al_quran/pages/quran/pages/juz/juz_Index_page.dart';
import 'package:nour_al_quran/pages/quran/pages/recitation/recitation_page.dart';
import 'package:nour_al_quran/pages/quran/pages/surah/surah_index_page.dart';
import 'package:nour_al_quran/pages/quran/providers/quran_provider.dart';
import 'package:nour_al_quran/pages/settings/pages/app_colors/app_colors_provider.dart';
import 'package:nour_al_quran/shared/localization/localization_constants.dart';
import 'package:nour_al_quran/shared/utills/app_colors.dart';
import 'package:nour_al_quran/shared/widgets/title_text.dart';
import 'package:provider/provider.dart';

class QuranPage extends StatelessWidget {
  const QuranPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ScrollController scrollController = ScrollController();
    var pageNames = [
      localeText(context, "recitation"),
      localeText(context, "surah"),
      localeText(context, "juz"),
      // localeText(context, "resume"),
      localeText(context, "bookmarks"),
      // localeText(context, "duas"),
      // localeText(context, "favorites")
    ];
    var pages = [
      const RecitationPage(),
      const SurahIndexPage(),
      const JuzIndexPage(),
      // const ResumePage(),
      const BookmarkPage(),
      //     const DuaCategoriesPage(),
      // const FavoritesRecitersPage(),
    ];
    return Scaffold(
      body: Consumer2<QuranProvider, AppColorsProvider>(
        builder: (context, value, appColors, child) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.only(
                    left: 20.w, top: 60.h, bottom: 12.h, right: 20.w),
                child: TitleText(
                  title: localeText(context, "quran"),
                  style: TextStyle(
                      fontFamily: 'satoshi',
                      fontSize: 22.sp,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                height: 23.h,
                margin: EdgeInsets.only(bottom: 15.h),
                child: ListView.builder(
                  padding: EdgeInsets.only(left: 20.w, right: 20.w),
                  controller: scrollController,
                  itemCount: pageNames.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return InkWell(
                        onTap: () async {
                          context.read<QuranProvider>().setCurrentPage(index);
                        },
                        child: Container(
                          height: 23.h,
                          padding: EdgeInsets.only(left: 9.w, right: 9.w),
                          margin: EdgeInsets.only(right: 7.w),
                          decoration: BoxDecoration(
                              color: index == value.currentPage
                                  ? appColors.mainBrandingColor
                                  : AppColors.grey6,
                              borderRadius: BorderRadius.circular(12.r)),
                          child: Center(
                              child: Text(
                            pageNames[index],
                            style: TextStyle(
                              color: index == value.currentPage
                                  ? Colors.white
                                  : AppColors.grey3,
                              fontWeight: FontWeight.w500,
                              fontFamily: 'satoshi',
                              fontSize: 15.sp,
                            ),
                          )),
                        ));
                  },
                ),
              ),
              Expanded(child: pages[value.currentPage])
            ],
          );
        },
      ),
    );
  }

  // Future<void> getData() async {}
}
