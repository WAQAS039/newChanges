import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nour_al_quran/pages/settings/pages/app_colors/app_colors_provider.dart';
import 'package:nour_al_quran/pages/settings/pages/app_them/them_provider.dart';
import 'package:nour_al_quran/shared/localization/localization_constants.dart';
import 'package:provider/provider.dart';

import '../../../shared/routes/routes_helper.dart';
import '../../../shared/utills/app_colors.dart';
import '../../../shared/widgets/circle_button.dart';
import '../../quran/pages/recitation/reciter/player/player_provider.dart';
import '../../settings/pages/my_state/my_state_provider_updated.dart';

class YourEngagementSection extends StatelessWidget {
  const YourEngagementSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer2<MyStateProvider, AppColorsProvider>(
      builder: (context, myState, appColor, child) {
        return Column(
          children: [
            Container(
              margin: EdgeInsets.only(
                left: 20.w,
                right: 20.w,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    localeText(context, 'your_engagement'),
                    style: TextStyle(
                        fontSize: 15.sp,
                        fontFamily: 'satoshi',
                        fontWeight: FontWeight.w900),
                  ),
                  Consumer<ThemProvider>(
                    builder: (context, them, child) {
                      return DropdownButton(
                        value: myState.yourEngagementCurrentDropDownItem,
                        style: TextStyle(
                            fontSize: 13.sp,
                            fontFamily: 'satoshi',
                            color:
                                them.isDark ? AppColors.grey4 : AppColors.grey2,
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
                      );
                    },
                  ),
                ],
              ),
            ),
            InkWell(
              onTap: () {
                Future.delayed(
                    Duration.zero,
                    () => context
                        .read<RecitationPlayerProvider>()
                        .pause(context));
                myState.stopAppUsageTimer();
                Navigator.of(context).pushNamed(RouteHelper.myState);
              },
              child: Container(
                margin: EdgeInsets.only(left: 20.w, right: 20.w, bottom: 14.h),
                // height: 68.h,
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
                      margin: const EdgeInsets.only(
                        left: 6.76,
                        top: 7.94,
                        right: 9.71,
                        bottom: 7.52,
                      ),
                      height: 52.54,
                      width: 52.54,
                      decoration: BoxDecoration(
                        color: AppColors.mainBrandingColor,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(6.37.r),
                        child: Image.asset(
                          'assets/images/app_icons/page.png',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 12.h, bottom: 10.h),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                _formatDuration(Duration(
                                    seconds:
                                        myState.yourEngagementAppUsageSeconds)),
                                style: TextStyle(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w700,
                                    fontFamily: "satoshi"),
                              ),
                              Container(
                                  margin: EdgeInsets.only(
                                      left: 4.w, right: 4.w, top: 3.h),
                                  child: CircleButton(
                                      height: 13.h,
                                      width: 13.w,
                                      icon: Icon(
                                        Icons.cloud,
                                        size: 6.w,
                                      ))),
                              Container(
                                margin: EdgeInsets.only(top: 3.h),
                                child: Text(
                                  '${myState.weeklyPercentage} ${localeText(context, 'from_last_week')}',
                                  style: TextStyle(
                                      fontFamily: 'satoshi',
                                      fontSize: 14.sp,
                                      color: appColor.mainBrandingColor),
                                ),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 4.h,
                          ),
                          Text(
                            localeText(context, 'lifetime'),
                            style: TextStyle(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w500,
                                fontFamily: "satoshi",
                                color: AppColors.grey3),
                          ),
                          SizedBox(
                            height: 4.h,
                          ),
                          Text(
                            _formatDuration(Duration(
                                seconds: myState.lifeTimeAppUsageSeconds)),
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontFamily: "satoshi",
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  String _formatDuration(Duration duration) {
    if (duration.inDays > 0) {
      final hours = duration.inHours - duration.inDays * 24;
      final minutes = duration.inMinutes - duration.inHours * 60;
      return '${duration.inDays}d${hours}h${minutes}m';
    } else if (duration.inSeconds <= 60) {
      return '${duration.inSeconds}s';
    } else if (duration.inSeconds >= 61 && duration.inMinutes <= 60) {
      return '${duration.inMinutes}m';
    } else {
      final hours = duration.inHours;
      final minutes = duration.inMinutes - duration.inHours * 60;
      return '${hours}h ${minutes}m';
    }
  }
}
