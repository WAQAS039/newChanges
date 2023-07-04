import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../../../shared/localization/localization_constants.dart';
import '../../shared/utills/app_colors.dart';
import '../../shared/widgets/title_text.dart';
import '../quran/pages/ruqyah/ruqyah_categories_page.dart';
import '../quran/providers/quran_provider.dart';
import '../settings/pages/app_colors/app_colors_provider.dart';
import 'dua_bookmarks.dart';
import 'dua_categories_page.dart';

class DuaCategoriesMain extends StatelessWidget {
  const DuaCategoriesMain({Key? key}) : super(key: key);

  // @override
  // Widget build(BuildContext context) {
  //   var appColors = context.read<AppColorsProvider>().mainBrandingColor;
  //   return Scaffold(
  //     appBar: buildAppBar(context: context, title: localeText(context, "dua")),
  //     body: DefaultTabController(
  //       length: 2,
  //       child: Column(
  //         children: [
  //           TabBar(
  //             indicatorColor: appColors,
  //             tabs: const [
  //               Tab(text: 'Dua'),
  //               Tab(text: 'Al-Ruqyah'),
  //             ],
  //           ),
  //           Expanded(
  //               child: TabBarView(
  //             children: [
  //               Column(
  //                 children: const [
  //                   Expanded(
  //                     child: DuaCategoriesPage(),
  //                   ),
  //                 ],
  //               ),
  //               Column(
  //                 children: const [
  //                   Expanded(
  //                     child: RuqyahCategoriesPage(),
  //                   ),
  //                 ],
  //               ),
  //             ],
  //           )),
  //         ],
  //       ),
  //     ),
  //   );
  // }
  @override
  Widget build(BuildContext context) {
    final ScrollController scrollController = ScrollController();
    var pageNames = [
      localeText(context, "duas"),
      localeText(context, "al_ruqyah"),
      localeText(context, "favorites"),
    ];
    var pages = [
      const DuaCategoriesPage(),
      const RuqyahCategoriesPage(),
      const DuaBookmarkPage(),
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
                  title: localeText(context, "duas"),
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
                              fontSize: 14.sp,
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
}
