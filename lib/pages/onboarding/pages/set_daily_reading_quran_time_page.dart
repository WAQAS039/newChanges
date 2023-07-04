import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nour_al_quran/pages/onboarding/on_boarding_provider.dart';
import 'package:nour_al_quran/pages/onboarding/widgets/on_boarding_text_widgets.dart';
import 'package:nour_al_quran/pages/settings/pages/app_colors/app_colors_provider.dart';
import 'package:nour_al_quran/pages/settings/pages/app_them/them_provider.dart';
import 'package:nour_al_quran/shared/localization/localization_constants.dart';
import 'package:nour_al_quran/shared/routes/routes_helper.dart';
import 'package:nour_al_quran/shared/utills/app_colors.dart';
import 'package:nour_al_quran/shared/widgets/brand_button.dart';
import 'package:provider/provider.dart';

class SetDailyQuranReadingTime extends StatelessWidget {
  const SetDailyQuranReadingTime({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var isDark = context.read<ThemProvider>().isDark;
    var appColors = context.read<AppColorsProvider>();
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.only(left: 20.w,right: 20.w,),
            child: Column(
              children: [
                OnBoardingTitleText(title: localeText(context, "how_much_time_would_you_like_to_read_the_quran_daily?")),
                Consumer<OnBoardingProvider>(
                  builder: (context,time,child) {
                    return buildTimingLists(context, time, isDark, appColors);
                  },
                ),
                SizedBox(height: 6.h,),
                BrandButton(text: localeText(context, "continue"), onTap: (){
                  Navigator.of(context).pushNamed(RouteHelper.preferredLanguage);
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }

  MediaQuery buildTimingLists(BuildContext context, OnBoardingProvider time, bool isDark, AppColorsProvider appColors) {
    return MediaQuery.removePadding(
      context: context,
      removeTop: true,
      removeBottom: true,
      child: ListView.builder(
        itemCount: time.dailyTime.length,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          String dailyTimes = time.dailyTime[index];
          return InkWell(
            onTap: (){
              time.selectDailyTime(index);
            },
            child: Container(
              margin: EdgeInsets.only(bottom: 10.h,),
              padding: EdgeInsets.only(left: 10.w,right: 10.w,top: 15.h,bottom: 15.h),
              decoration: BoxDecoration(
                  color: dailyTimes == time.selectedDailyTime ? isDark ? AppColors.brandingDark : AppColors.lightBrandingColor : Colors.transparent,
                  border: Border.all(color: dailyTimes == time.selectedDailyTime ? appColors.mainBrandingColor : isDark ? AppColors.grey3 : AppColors.grey5),
                  borderRadius: BorderRadius.circular(6.r)
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(localeText(context, dailyTimes),style: TextStyle(
                      fontFamily: 'satoshi',
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w500
                  ),),
                  dailyTimes == time.selectedDailyTime ? Stack(
                      children: [
                        Icon(Icons.circle,size: 17.h,color: isDark ? Colors.white : appColors.mainBrandingColor,),
                        Positioned(
                            left: 0, right: 0, top: 0, bottom: 0,
                            child: Icon(Icons.circle,size: 9.h,color: isDark ? appColors.mainBrandingColor : Colors.white,))]) :
                  Icon(Icons.circle,size: 17.h,color: AppColors.grey5,)
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
