import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nour_al_quran/pages/quran/pages/recitation/reciter/player/player_provider.dart';
import 'package:nour_al_quran/pages/quran/providers/quran_provider.dart';
import 'package:nour_al_quran/pages/quran/widgets/quran_text_view.dart';
import 'package:nour_al_quran/pages/settings/pages/app_colors/app_colors_provider.dart';
import 'package:nour_al_quran/shared/localization/localization_constants.dart';
import 'package:nour_al_quran/pages/quran/pages/resume/last_seen_provider.dart';
import 'package:nour_al_quran/pages/settings/pages/app_them/them_provider.dart';
import 'package:nour_al_quran/shared/utills/app_colors.dart';
import 'package:provider/provider.dart';

import '../../../../shared/localization/localization_provider.dart';

class WhereULeftOffWidget extends StatelessWidget {
  const WhereULeftOffWidget({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Future.delayed(
        Duration.zero, () => context.read<LastSeenProvider>().getLastSeen());
    return Consumer3<LastSeenProvider, ThemProvider, AppColorsProvider>(
      builder: (context, lastSeenValue, them, appColors, child) {
        return lastSeenValue.lastSeen != null
            ? InkWell(
                onTap: () async {
                  if (lastSeenValue.lastSeen!.isJuz!) {
                    context.read<QuranProvider>().setJuzText(
                          juzId: lastSeenValue.lastSeen!.juzId!,
                          title: lastSeenValue.lastSeen!.juzArabic!,
                          fromWhere: 0,
                          isJuz: true,
                        );

                    /// if recitation player is on So this line is used to pause the player
                    Future.delayed(
                        Duration.zero,
                        () => context
                            .read<RecitationPlayerProvider>()
                            .pause(context));
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) {
                        return const QuranTextView();
                      },
                    ));
                  } else {
                    // coming from surah so isJuz already false
                    // coming from surah so JuzId already -1
                    context.read<QuranProvider>().setSurahText(
                        surahId: lastSeenValue.lastSeen!.surahId!,
                        title:
                            'سورة ${lastSeenValue.lastSeen!.surahNameArabic}',
                        fromWhere: 0);

                    /// if recitation player is on So this line is used to pause the player
                    Future.delayed(
                        Duration.zero,
                        () => context
                            .read<RecitationPlayerProvider>()
                            .pause(context));
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) {
                        return const QuranTextView();
                      },
                    ));
                  }
                },
                child: Container(
                  margin: EdgeInsets.only(
                    left: 20.w,
                    right: 20.h,
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: AppColors.grey5,
                    ),
                    borderRadius: BorderRadius.circular(4.78.r),
                    // color: AppColors.lightBlue
                  ),
                  child: Row(
                    children: [
                      buildSurahNameCircle(appColors, lastSeenValue),
                      buildSurahDetailsContainer(lastSeenValue, context, them)
                    ],
                  ),
                ),
              )
            : const SizedBox.shrink();
      },
    );
  }

  Container buildSurahDetailsContainer(
      LastSeenProvider lastSeenValue, BuildContext context, ThemProvider them) {
    return Container(
      margin: EdgeInsets.only(top: 16.h, bottom: 17.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            LocalizationProvider().locale.languageCode == "ur" ||
                    LocalizationProvider().locale.languageCode == "ar"
                ? lastSeenValue.lastSeen!.surahNameArabic!
                : lastSeenValue.lastSeen!.surahName!,
            style: TextStyle(
                // color: Colors.black,
                fontSize: 14.sp,
                fontWeight: FontWeight.w700,
                fontFamily: "satoshi"),
          ),
          SizedBox(
            height: 1.h,
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.6,
            child: Text(
              LocalizationProvider().checkIsArOrUr()
                  ? "${localeText(context, "surah")} ${lastSeenValue.lastSeen!.surahId}"
                  : "${lastSeenValue.lastSeen!.surahEnglish!}, ${localeText(context, "surah")} # ${lastSeenValue.lastSeen!.surahId}",
              style: TextStyle(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w500,
                  fontFamily: "satoshi",
                  color: them.isDark ? AppColors.grey4 : AppColors.grey1),
            ),
          ),
          SizedBox(
            height: 1.h,
          ),
          // ${locateText(context, 'page')} 231
          Text(
            '${localeText(context, 'ayat')} ${lastSeenValue.lastSeen!.ayahId} ',
            style: TextStyle(
                fontSize: 12.sp,
                fontFamily: "satoshi",
                fontWeight: FontWeight.w500,
                color: them.isDark ? AppColors.grey4 : AppColors.grey3),
          ),
        ],
      ),
    );
  }

  Container buildSurahNameCircle(
      AppColorsProvider appColors, LastSeenProvider lastSeenValue) {
    return Container(
      margin: EdgeInsets.only(
          left: 8.76.w, top: 11.94.h, right: 9.w, bottom: 11.52.h),
      padding: EdgeInsets.all(7.16.h),
      height: 52.54.h,
      width: 52.54.w,
      decoration: BoxDecoration(
          color: appColors.mainBrandingColor,
          borderRadius: BorderRadius.circular(6.37.r)),
      child: CircleAvatar(
          child: Text(
        lastSeenValue.lastSeen!.surahNameArabic!,
        style: TextStyle(fontSize: 12.sp, fontFamily: "Al Majeed Quranic Font"),
      )),
    );
  }
}