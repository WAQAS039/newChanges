import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nour_al_quran/pages/settings/pages/app_colors/app_colors_provider.dart';
import 'package:provider/provider.dart';

import '../../../../../shared/localization/localization_constants.dart';
import '../../../../../shared/localization/localization_provider.dart';
import '../../../../../shared/utills/app_colors.dart';
import '../../../../../shared/widgets/custom_track_shape.dart';
import '../my_state_provider_updated.dart';

class AchievementSection extends StatelessWidget {
  const AchievementSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double value = Provider.of<MyStateProvider>(context,listen: false).streak!.streakLevel!.toDouble();
    return Consumer2<MyStateProvider,AppColorsProvider>(
      builder: (context, myState,appColor, child) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(localeText(context, "acheivements"),style: TextStyle(fontSize: 14.sp, fontFamily: 'satoshi',fontWeight: FontWeight.w700)),
            Container(
              margin: EdgeInsets.only(top: 8.h,bottom: 10.h),
              padding: EdgeInsets.only(top: 12.h,left: 8.w,right: 8.w,bottom: 9.h),
              width: double.maxFinite,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6.r),
                  border: Border.all(color: AppColors.grey5)
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("${localeText(context, "great_you_are_on_a")} ${myState.streak!.streakLevel} ${localeText(context, "day_streak")}",style: TextStyle(fontSize: 12.sp,fontFamily: 'satoshi',fontWeight: FontWeight.w500),),
                  Container(
                    margin: EdgeInsets.only(top: 13.h),
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Container(height: 50,),
                        Positioned(
                          left: LocalizationProvider().checkIsArOrUr() ? null : value * (290/10),
                          right: LocalizationProvider().checkIsArOrUr() ? value * (290/10) : null,
                          top: 0,
                          child: Container(
                            width: 18.w,
                            height: 18.h,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: appColor.mainBrandingColor,
                              borderRadius: BorderRadius.circular(6.r),
                            ),
                            child: Text(
                              value.toInt().toString(),
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14.sp,
                                fontFamily: 'satoshi',
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          top: 28.h,
                          left: 0,
                          right: 0,
                          child: SliderTheme(
                            data: SliderThemeData(
                              overlayShape: SliderComponentShape.noOverlay,
                              trackHeight: 10.h,
                              trackShape: CustomTrackShape(),
                              thumbShape: const RoundSliderThumbShape(
                                elevation: 0.0,
                                enabledThumbRadius: 6.2,
                              ),
                            ),
                            child: Slider(
                              value: value,
                              min: 0.0,
                              max: myState.maxStreak,
                              thumbColor: appColor.mainBrandingColor,
                              activeColor: appColor.mainBrandingColor,
                              inactiveColor: AppColors.lightBrandingColor,
                              onChanged: (newValue) {},
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Text(localeText(context, "streak_level"), style: TextStyle(fontSize: 14.sp, fontFamily: 'satoshi',fontWeight: FontWeight.w700),
                  ),
                ],
              ),
            )
          ],
        );
      },
    );
  }
}
