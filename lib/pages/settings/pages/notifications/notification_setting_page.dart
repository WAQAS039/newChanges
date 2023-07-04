import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nour_al_quran/shared/localization/localization_constants.dart';
import 'package:nour_al_quran/shared/widgets/title_row.dart';
import 'package:provider/provider.dart';

import '../../../../shared/widgets/app_bar.dart';
import '../../../onboarding/models/common.dart';
import '../../../onboarding/on_boarding_provider.dart';
import '../app_colors/app_colors_provider.dart';

class NotificationSettingPage extends StatelessWidget {
  const NotificationSettingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context: context,title: localeText(context, "notifications")),
      body: Consumer2<OnBoardingProvider,AppColorsProvider>(
        builder: (context, notify,appColors, child) {
          return ListView.builder(
            padding: EdgeInsets.only(bottom: 50.h,left: 20.w,right: 20.w),
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
                    Text(localeText(context, notificationList.title!),style: TextStyle(
                      fontSize: 16.sp
                    ),),
                    SizedBox(
                      height: 21.h,
                      width: 31.w,
                      child: FittedBox(
                          fit: BoxFit.fill,
                          child: CupertinoSwitch(
                              activeColor: appColors.mainBrandingColor,
                              value: notificationList.isSelected!, onChanged: (value){
                            notify.setNotification(index, value);
                          })),
                    ),
                  ],
                ),
              );
            },);
        },
      ),
    );
  }
}
