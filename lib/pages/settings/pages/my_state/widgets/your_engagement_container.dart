import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nour_al_quran/pages/settings/pages/app_colors/app_colors_provider.dart';
import 'package:nour_al_quran/pages/settings/pages/app_them/them_provider.dart';
import 'package:nour_al_quran/pages/settings/pages/my_state/my_state_page.dart';
import 'package:provider/provider.dart';

import '../../../../../shared/localization/localization_constants.dart';
import '../../../../../shared/utills/app_colors.dart';
import '../../../../../shared/widgets/circle_button.dart';
import '../my_state_provider_updated.dart';

class YourEngagementContainer extends StatelessWidget {
  const YourEngagementContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer3<MyStateProvider, ThemProvider, AppColorsProvider>(
      builder: (context, myState, them, appColor, child) {
        return Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  localeText(context, 'your_engagement'),
                  style: TextStyle(
                      fontSize: 14.sp,
                      fontFamily: 'satoshi',
                      fontWeight: FontWeight.w900),
                ),
                DropdownButton(
                  value: myState.yourEngagementCurrentDropDownItem,
                  style: TextStyle(
                      fontSize: 11.sp,
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
                    myState.setYourEngagementCurrentDropDownItem(value!);
                    myState.getSeconds(value, "engagement");
                  },
                ),
              ],
            ),
            Container(
              margin: EdgeInsets.only(bottom: 14.h),
              decoration: BoxDecoration(
                border: Border.all(
                  color: AppColors.grey5,
                ),
                borderRadius: BorderRadius.circular(4.78.r),
                // color: AppColors.lightBlue
              ),
              child: Row(
                children: [
                  Container(
                    margin: EdgeInsets.only(
                        left: 6.76.w,
                        top: 7.94.h,
                        right: 9.71.w,
                        bottom: 7.52.h),
                    height: 52.54.h,
                    width: 52.54.w,
                    // decoration: BoxDecoration(
                    //   color: AppColors.mainBrandingColor,
                    //   //   borderRadius: BorderRadius.circular(9.r)
                    // ),
                    child: Image.asset(
                      'assets/images/app_icons/hourglass.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 12.h, bottom: 10.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          formatDuration(Duration(
                              seconds: myState.yourEngagementAppUsageSeconds)),
                          // time.inSeconds <= 60 ? '${time.inSeconds}s' : time.inSeconds >= 61 && time.inMinutes <= 60?  '${time.inMinutes} ${localeText(context,'minutes')}'
                          //     : '${time.inHours}h${time.inMinutes - 60} ${localeText(context,'minutes_today')}',
                          style: TextStyle(
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w700,
                              fontFamily: "satoshi"),
                        ),
                        SizedBox(
                          height: 4.h,
                        ),
                        myState.weeklyPercentage != 0.0
                            ? Row(
                                children: [
                                  Container(
                                      margin:
                                          EdgeInsets.only(right: 4.w, top: 3.h),
                                      child: CircleButton(
                                          height: 11.h,
                                          width: 11.w,
                                          icon: Icon(
                                            Icons.cloud,
                                            size: 5.w,
                                          ))),
                                  Container(
                                    margin: EdgeInsets.only(top: 3.h),
                                    child: Text(
                                      '${myState.weeklyPercentage}% ${localeText(context, 'from_last_week')}',
                                      style: TextStyle(
                                          fontFamily: 'satoshi',
                                          fontSize: 13.sp,
                                          color: appColor.mainBrandingColor),
                                    ),
                                  )
                                ],
                              )
                            : Container(
                                margin: EdgeInsets.only(top: 3.h),
                                child: Text(
                                  '0%',
                                  style: TextStyle(
                                      fontFamily: 'satoshi',
                                      fontSize: 13.sp,
                                      color: appColor.mainBrandingColor),
                                ),
                              ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
