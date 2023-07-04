import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nour_al_quran/pages/more/pages/tasbeeh/provider/tasbeeh_provider.dart';
import 'package:provider/provider.dart';

import '../../../../../shared/localization/localization_provider.dart';
import '../../../../../shared/utills/app_colors.dart';
import '../../../../settings/pages/app_colors/app_colors_provider.dart';
import '../../../../settings/pages/app_them/them_provider.dart';

class FingerPrintSection extends StatelessWidget {
  const FingerPrintSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var appColors = Provider.of<AppColorsProvider>(context, listen: false);
    var language = Provider.of<LocalizationProvider>(context, listen: false);
    var them = Provider.of<ThemProvider>(context, listen: false);
    return Consumer<TasbeehProvider>(
      builder: (context, tasbeehValue, child) {
        return Container(
          margin: EdgeInsets.only(left: 20.w, right: 20.w, top: 28.h),
          decoration: BoxDecoration(
              color: them.isDark ? AppColors.darkColor : Colors.white,
              borderRadius: BorderRadius.circular(10.r),
              boxShadow: const [
                BoxShadow(
                    offset: Offset(0, 5),
                    blurRadius: 15,
                    color: Color.fromRGBO(0, 0, 0, 0.08))
              ]),
          child: InkWell(
            onTap: () {
              tasbeehValue.increaseCounter();
            },
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                        margin:
                            EdgeInsets.only(top: 10.h, left: 10.w, right: 10.w),
                        child: Image.asset(
                          language.locale.languageCode == "ur" ||
                                  language.locale.languageCode == "ar"
                              ? 'assets/images/app_icons/frame_left_t.png'
                              : 'assets/images/app_icons/frame_right_t.png',
                          height: 43.h,
                          width: 43.w,
                          color: appColors.mainBrandingColor,
                        )),
                    Container(
                        margin:
                            EdgeInsets.only(top: 10.h, right: 10.w, left: 10.w),
                        child: Image.asset(
                          language.locale.languageCode == "ur" ||
                                  language.locale.languageCode == "ar"
                              ? 'assets/images/app_icons/frame_right_t.png'
                              : 'assets/images/app_icons/frame_left_t.png',
                          height: 43.h,
                          width: 43.w,
                          color: appColors.mainBrandingColor,
                        )),
                  ],
                ),
                Text(
                  '${tasbeehValue.counter}/${tasbeehValue.currentCounter}',
                  // '${tasbeehValue.customCounter == 0 ? tasbeehValue.currentTabeeh == 2 ? tasbeehValue.counterList[tasbeehValue.selectedCounter] +1 : tasbeehValue.counterList[tasbeehValue.selectedCounter] : tasbeehValue.customCounter}',
                  style: TextStyle(
                      color: appColors.mainBrandingColor,
                      fontSize: 22.sp,
                      fontWeight: FontWeight.w700,
                      fontFamily: 'satoshi'),
                ),
                Container(
                    margin: EdgeInsets.only(top: 30.h, bottom: 30.h),
                    child: Image.asset(
                      'assets/images/app_icons/fingerprint.png',
                      height: 138.h,
                      width: 138.w,
                      color: them.isDark ? Colors.white : AppColors.grey1,
                    )),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                        margin: EdgeInsets.only(
                            bottom: 10.h, left: 10.w, right: 10.w),
                        child: Image.asset(
                          language.locale.languageCode == "ur" ||
                                  language.locale.languageCode == "ar"
                              ? 'assets/images/app_icons/frame_left_b.png'
                              : 'assets/images/app_icons/frame_right_b.png',
                          height: 43.h,
                          width: 43.w,
                          color: appColors.mainBrandingColor,
                        )),
                    Container(
                        margin: EdgeInsets.only(
                            bottom: 10.h, right: 10.w, left: 10.w),
                        child: Image.asset(
                          language.locale.languageCode == "ur" ||
                                  language.locale.languageCode == "ar"
                              ? 'assets/images/app_icons/frame_right_b.png'
                              : 'assets/images/app_icons/frame_left_b.png',
                          height: 43.h,
                          width: 43.w,
                          color: appColors.mainBrandingColor,
                        )),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
