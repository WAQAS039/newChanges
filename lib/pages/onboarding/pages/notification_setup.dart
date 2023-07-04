import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive/hive.dart';
import 'package:nour_al_quran/pages/onboarding/models/common.dart';
import 'package:nour_al_quran/pages/onboarding/on_boarding_provider.dart';
import 'package:nour_al_quran/pages/onboarding/widgets/on_boarding_text_widgets.dart';
import 'package:nour_al_quran/pages/settings/pages/app_colors/app_colors_provider.dart';
import 'package:nour_al_quran/shared/localization/localization_constants.dart';
import 'package:nour_al_quran/shared/routes/routes_helper.dart';
import 'package:nour_al_quran/shared/widgets/brand_button.dart';
import 'package:provider/provider.dart';

import '../../../shared/localization/localization_provider.dart';
import '../../../shared/utills/app_constants.dart';
import '../../settings/pages/notifications/notification_services.dart';
import '../models/on_boarding_information.dart';

class NotificationSetup extends StatelessWidget {
  const NotificationSetup({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.only(
            left: 20.w,
            right: 20.w,
          ),
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(bottom: 4.h, top: 28.h),
                child: Text(
                  localeText(context, "turn_on_notifications_to_get_the_most_out_of_quran_pro?"),
                  style: TextStyle(
                      fontFamily: "satoshi",
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w900),
                  textAlign: TextAlign.justify,
                ),
              ),
              OnBoardingSubTitleText(
                title: localeText(context, "receive_personalized_recommedations,_hadiths,_athan,_duas_and_other_reminders_to_enhance_your_spirtual_journey._you_can_opt_out_anytime"),
              ),
              _buildNotificationList(),
              BrandButton(
                  text: localeText(context, "finish_setup"),
                  onTap: () {
                    saveOnBoarding();
                    Navigator.of(context).pushNamedAndRemoveUntil(RouteHelper.reviewOne, (route) => false);
                  })
            ],
          ),
        ),
      ),
    );
  }

  _buildNotificationList() {
    return Consumer2<OnBoardingProvider, AppColorsProvider>(
      builder: (context, notify, appColors, child) {
        return ListView.builder(
          padding: EdgeInsets.only(bottom: 50.h),
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: notify.notification.length,
          itemBuilder: (context, index) {
            Common notificationList = notify.notification[index];
            return Container(
              margin: EdgeInsets.only(top: 15.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(localeText(context, notificationList.title!)),
                  SizedBox(
                    height: 20.h,
                    width: 32.w,
                    child: FittedBox(
                        fit: BoxFit.fill,
                        child: CupertinoSwitch(
                            activeColor: appColors.mainBrandingColor,
                            value: notificationList.isSelected!,
                            onChanged: (value) {
                              notify.setNotification(index, value);
                            })),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }


  void saveOnBoarding() {
    print("saved On Board");
    LocalizationProvider localization = LocalizationProvider();
    OnBoardingProvider provider = OnBoardingProvider();
    OnBoardingInformation onBoardingInfo = OnBoardingInformation(
        purposeOfQuran: provider.selectAchieveWithQuranList,
        favReciter: provider.favReciter,
        preferredLanguage: localization.locale
      // whenToReciterQuran: provider.selectTimeLikeToRecite,
      // recitationReminder: provider.recitationReminderTime,
      // dailyQuranReadTime: provider.selectedDailyTime,
    );
    Hive.box(appBoxKey).put(onBoardingInformationKey, onBoardingInfo);
  }
}
