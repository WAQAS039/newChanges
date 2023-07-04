import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nour_al_quran/pages/more/pages/salah_timer/provider.dart';
import 'package:nour_al_quran/shared/localization/localization_constants.dart';
import 'package:provider/provider.dart';

import '../../../../shared/widgets/app_bar.dart';

class SalahTimerSetting extends StatelessWidget {
  const SalahTimerSetting({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(
          context: context, title: localeText(context, "salah_settings")),
      body: Consumer<PrayerTimeProvider>(
        builder: (context, salah, child) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.only(top: 20.h, left: 20.w, right: 20.w),
                child: Text(
                  localeText(context, 'choose_Style'),
                  style: TextStyle(
                      fontSize: 14.sp,
                      fontFamily: 'satoshi',
                      fontWeight: FontWeight.w700),
                ),
              ),
              Stack(
                children: [
                  InkWell(
                    onTap: () {
                      salah.changeThem(1);
                    },
                    child: Container(
                      height: 114.h,
                      margin: EdgeInsets.only(
                          top: 13.h, left: 20.w, right: 20.w, bottom: 4.h),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6.r),
                          image: const DecorationImage(
                              fit: BoxFit.fill,
                              image: AssetImage(
                                  'assets/images/salah_timer/them_2/1.png'))),
                    ),
                  ),
                  Positioned(
                      right: 40.w,
                      top: 20.h,
                      child: Image.asset(
                        salah.selectedThem == 1
                            ? 'assets/images/app_icons/selected.png'
                            : 'assets/images/app_icons/unselected.png',
                        height: 24.h,
                        width: 24.w,
                      )
                      // Icon(Icons.check_circle,color: salah.selectedThem == 1 ? Colors.white : Colors.white.withOpacity(0.6),)
                      )
                ],
              ),
              Stack(
                children: [
                  InkWell(
                    onTap: () {
                      salah.changeThem(2);
                    },
                    child: Container(
                      height: 114.h,
                      width: double.maxFinite,
                      margin: EdgeInsets.only(
                          top: 13.h, left: 20.w, right: 20.w, bottom: 4.h),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6.r),
                          image: const DecorationImage(
                              fit: BoxFit.fill,
                              image: AssetImage(
                                  'assets/images/salah_timer/them_1/1.png'))),
                    ),
                  ),
                  Positioned(
                      right: 40.w,
                      top: 20.h,
                      child: Image.asset(
                        salah.selectedThem == 2
                            ? 'assets/images/app_icons/selected.png'
                            : 'assets/images/app_icons/unselected.png',
                        height: 24.h,
                        width: 24.w,
                      ))
                ],
              )
            ],
          );
        },
      ),
    );
  }
}
