import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nour_al_quran/pages/onboarding/on_boarding_provider.dart';
import 'package:nour_al_quran/pages/onboarding/widgets/skip_button.dart';
import 'package:nour_al_quran/pages/onboarding/widgets/on_boarding_text_widgets.dart';
import 'package:nour_al_quran/pages/settings/pages/app_colors/app_colors_provider.dart';
import 'package:nour_al_quran/pages/settings/pages/app_them/them_provider.dart';
import 'package:nour_al_quran/shared/database/quran_db.dart';
import 'package:nour_al_quran/shared/localization/localization_constants.dart';
import 'package:nour_al_quran/shared/routes/routes_helper.dart';
import 'package:nour_al_quran/shared/utills/app_colors.dart';
import 'package:nour_al_quran/shared/widgets/brand_button.dart';
import 'package:provider/provider.dart';

import '../models/fav_reciter.dart';

class SetFavReciter extends StatelessWidget {
  const SetFavReciter({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var isDark = context.read<ThemProvider>().isDark;
    var appColors = context.read<AppColorsProvider>();
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.only(
              left: 20.w,
              right: 20.w,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                OnBoardingTitleText(
                    title: localeText(context,
                        "beautiful_recitations_from_around_the_world")),
                OnBoardingSubTitleText(
                    title: localeText(context, "set_your_favorite_reciter")),
                Consumer<OnBoardingProvider>(
                  builder: (context, setReciter, child) {
                    return MediaQuery.removePadding(
                      context: context,
                      removeTop: true,
                      removeBottom: true,
                      child: ListView.builder(
                        itemCount: setReciter.reciterList.length,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          FavReciter reciter = setReciter.reciterList[index];
                          return InkWell(
                            onTap: () {
                              setReciter.setFavReciter(index);
                            },
                            child: _buildReciterNameContainer(
                                reciter, setReciter, isDark, appColors, index),
                          );
                        },
                      ),
                    );
                  },
                ),
                BrandButton(
                    text: localeText(context, "continue"),
                    onTap: () async {
                      var selectedReciterIds = context.read<OnBoardingProvider>().reciterList.where((reciter) => reciter.title ==
                          context.read<OnBoardingProvider>().favReciter)
                          .map((reciter) => reciter.reciterId)
                          .toList();
                      // Assuming you have access to the DBHelper instance
                      var dbHelper = QuranDatabase();

                      // Iterate over the selected reciter IDs and update the is_fav value
                      for (var reciterId in selectedReciterIds) {
                        await dbHelper.updateReciterIsFav(
                            reciterId!, 1); // Set the value to 1 for true
                      }

                      // Navigator.of(context).pushNamed(RouteHelper.quranReminder);
                      Navigator.of(context)
                          .pushNamed(RouteHelper.notificationSetup);
                    }),
                SizedBox(
                  height: 16.h,
                ),
                SkipButton(onTap: () {
                  Navigator.of(context).pushNamed(RouteHelper.notificationSetup);
                  // Navigator.of(context).pushNamed(RouteHelper.quranReminder);
                })
              ],
            ),
          ),
        ),
      ),
    );
  }

  Container _buildReciterNameContainer(
      FavReciter reciter,
      OnBoardingProvider setReciter,
      bool isDark,
      AppColorsProvider appColors,
      int index) {
    return Container(
      margin: EdgeInsets.only(
        bottom: 15.h,
      ),
      padding:
          EdgeInsets.only(left: 10.w, right: 10.w, top: 15.h, bottom: 15.h),
      decoration: BoxDecoration(
          color: reciter.title == setReciter.favReciter
              ? isDark
                  ? AppColors.brandingDark
                  : AppColors.lightBrandingColor
              : Colors.transparent,
          border: Border.all(
              color: reciter.title == setReciter.favReciter
                  ? appColors.mainBrandingColor
                  : isDark
                      ? AppColors.grey3
                      : AppColors.grey5),
          borderRadius: BorderRadius.circular(6.r)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            reciter.title!,
            style: TextStyle(
                fontFamily: 'satoshi',
                fontSize: 12.sp,
                fontWeight: FontWeight.w500),
          ),
          reciter.title == setReciter.favReciter
              ? Row(
                  children: [
                    reciter.isPlaying!
                        ? Image.asset(
                            "assets/images/app_icons/sound_waves.png",
                            height: 20.78.h,
                            width: 27.46.w,
                            color: isDark
                                ? Colors.white
                                : appColors.mainBrandingColor,
                          )
                        : InkWell(
                            onTap: () {
                              setReciter.setIsPlaying(index);
                            },
                            child: Image.asset(
                              "assets/images/app_icons/play_mainplayer.png",
                              height: 17.h,
                              width: 17.w,
                            )),
                    SizedBox(
                      width: 9.w,
                    ),
                    Stack(
                      children: [
                        Icon(
                          Icons.circle,
                          size: 17.h,
                          color: isDark
                              ? Colors.white
                              : appColors.mainBrandingColor,
                        ),
                        Positioned(
                            left: 0,
                            right: 0,
                            top: 0,
                            bottom: 0,
                            child: Icon(
                              Icons.circle,
                              size: 9.h,
                              color: isDark
                                  ? appColors.mainBrandingColor
                                  : Colors.white,
                            ))
                      ],
                    ),
                  ],
                )
              : Row(
                  children: [
                    Image.asset(
                      "assets/images/app_icons/play_mainplayer.png",
                      height: 17.h,
                      width: 17.w,
                    ),
                    SizedBox(
                      width: 9.w,
                    ),
                    Icon(
                      Icons.circle,
                      size: 17.h,
                      color: AppColors.grey5,
                    ),
                  ],
                )
        ],
      ),
    );
  }
}
