import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nour_al_quran/pages/settings/pages/app_colors/app_colors_provider.dart';
import 'package:nour_al_quran/pages/settings/pages/app_them/them_provider.dart';
import 'package:nour_al_quran/shared/utills/app_colors.dart';
import 'package:provider/provider.dart';

import '../../../../../shared/localization/localization_constants.dart';
import '../my_state_page.dart';
import '../my_state_provider_updated.dart';

class AverageStatsSection extends StatelessWidget {
  const AverageStatsSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer3<MyStateProvider, ThemProvider, AppColorsProvider>(
      builder: (context, myState, them, appColor, child) {
        return Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(localeText(context, "average_stats"),
                    style: TextStyle(
                        fontSize: 14.sp,
                        fontFamily: 'satoshi',
                        fontWeight: FontWeight.w700)),
                DropdownButton(
                  value: myState.averageStatsCurrentDropDownItem,
                  style: TextStyle(
                      fontSize: 12.sp,
                      fontFamily: 'satoshi',
                      color: them.isDark ? AppColors.grey4 : AppColors.grey2,
                      fontWeight: FontWeight.w500),
                  underline: const SizedBox.shrink(),
                  iconSize: 20.h,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(7.4.r),
                      bottomRight: Radius.circular(7.4.r),
                      bottomLeft: Radius.circular(7.4.r)),
                  items: myState.dropDown
                      .map((e) => DropdownMenuItem(
                            value: e,
                            child: Text(e),
                          ))
                      .toList(),
                  onChanged: (value) {
                    myState.setAverageStatsCurrentDropDownItem(value!);
                    myState.getSeconds(value, "other");
                  },
                ),
              ],
            ),
            GridView(
              physics: const NeverScrollableScrollPhysics(),
              padding: EdgeInsets.only(bottom: 13.h, top: 8.h),
              shrinkWrap: true,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisExtent: 110.h,
                  mainAxisSpacing: 13.h,
                  crossAxisSpacing: 13.w),
              children: [
                buildAverageStatsContainer(
                    myState.streak!.streakLevel.toString(),
                    localeText(context, "current_streak"),
                    false,
                    appColor.mainBrandingColor,
                    context),
                buildAverageStatsContainer(
                    formatDuration(
                        Duration(seconds: myState.quranReadingSeconds)),
                    localeText(context, "average_quran_reading"),
                    true,
                    appColor.mainBrandingColor,
                    context),
                buildAverageStatsContainer(
                    formatDuration(
                        Duration(seconds: myState.recitationSeconds)),
                    localeText(context, "average_quran_recitation"),
                    true,
                    appColor.mainBrandingColor,
                    context),
                buildAverageStatsContainer(
                    formatDuration(Duration(seconds: myState.appUsageSeconds)),
                    localeText(context, "average_time_spent"),
                    true,
                    appColor.mainBrandingColor,
                    context),
              ],
            ),
          ],
        );
      },
    );
  }

  buildAverageStatsContainer(String title, String subTitle, bool isMin,
      Color appColor, BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 29.h, left: 8.w, right: 8.w),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6.r),
          border: Border.all(color: AppColors.grey5)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(title,
                  style: TextStyle(
                      fontSize: 33.sp,
                      fontFamily: 'satoshi',
                      fontWeight: FontWeight.w700,
                      color: appColor)),
              Text(isMin ? "" : "  ${localeText(context, "days")}",
                  style: TextStyle(
                      fontSize: 16.sp,
                      fontFamily: 'satoshi',
                      fontWeight: FontWeight.w700,
                      color: appColor))
              // "  ${localeText(context, "minutes")}"
            ],
          ),
          Text(subTitle,
              style: TextStyle(
                  fontSize: 12.sp,
                  fontFamily: 'satoshi',
                  fontWeight: FontWeight.w700))
        ],
      ),
    );
  }
}
