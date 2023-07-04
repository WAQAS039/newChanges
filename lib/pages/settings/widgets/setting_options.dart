import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nour_al_quran/pages/settings/pages/app_colors/app_colors_provider.dart';
import 'package:nour_al_quran/shared/localization/localization_provider.dart';
import 'package:nour_al_quran/pages/settings/pages/app_them/them_provider.dart';
import 'package:nour_al_quran/shared/utills/app_colors.dart';
import 'package:provider/provider.dart';

class SettingOptions extends StatelessWidget {
  final String title;
  final String? subTitle;
  final String icon;
  final Widget trailing;
  final VoidCallback onTap;
  const SettingOptions(
      {Key? key,
      required this.title,
      this.subTitle = "",
      required this.icon,
      required this.trailing,
      required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Consumer3<ThemProvider, AppColorsProvider, LocalizationProvider>(
        builder: (context, value, appColors, language, child) {
          return Container(
            width: double.maxFinite,
            color: value.isDark
                ? AppColors.darkColor
                : AppColors.settingsContainerColor,
            padding: EdgeInsets.only(
                left: 20.w, right: 20.w, top: 10.4.h, bottom: 9.45.h),
            margin: EdgeInsets.only(top: 10.h),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 34.h,
                  width: 36.w,
                  margin: EdgeInsets.only(
                      right: 17.w,
                      left: language.locale.languageCode == "ur" ||
                              language.locale.languageCode == "ar"
                          ? 17.w
                          : 0),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6.r),
                      color: appColors.mainBrandingColor),
                  child: ImageIcon(
                    AssetImage("assets/images/app_icons/$icon"),
                    color: Colors.white,
                    size: 15.69.h,
                  ),
                ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                        width: MediaQuery.of(context).size.width * 0.6,
                        child: Text(
                          title,
                          style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontFamily: 'satoshi',
                              fontSize: 15.sp),
                        )),
                    subTitle != ""
                        ? Text(
                            subTitle!,
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontFamily: 'satoshi',
                                fontSize: 12.sp,
                                color: !value.isDark
                                    ? AppColors.grey2
                                    : AppColors.grey3),
                          )
                        : Container()
                  ],
                ),
                const Spacer(),
                trailing
              ],
            ),
          );
        },
      ),
    );
  }
}
