import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nour_al_quran/pages/settings/pages/app_colors/app_colors_provider.dart';
import 'package:nour_al_quran/pages/settings/pages/app_them/them_provider.dart';
import 'package:nour_al_quran/pages/settings/pages/fonts/font_provider.dart';
import 'package:nour_al_quran/shared/utills/app_colors.dart';
import 'package:provider/provider.dart';

class DuaContainer1 extends StatelessWidget {
  final String? text;
  final String? translation;
  final String? ref;
  const DuaContainer1(
      {Key? key, this.text = "", this.translation = "", this.ref})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final appColors = Provider.of<AppColorsProvider>(context);
    final isDark = Provider.of<ThemProvider>(context).isDark;
    return Container(
      width: double.maxFinite,
      // decoration: BoxDecoration(
      //   color: isDark ? Colors.transparent : AppColors.grey6,
      //   borderRadius: BorderRadius.circular(6.r),
      //   border: Border.all(
      //     color: AppColors.grey5,
      //   ),
      //   // color: AppColors.grey5
      // ),
      margin: EdgeInsets.only(
        left: 20.w,
        right: 20.w,
      ),
      padding: EdgeInsets.only(
        left: 22.w,
        right: 22.w,
        top: 10.h,
      ),
      child: Consumer<FontProvider>(
        builder: (context, fontProvider, child) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (text != null && text!.isNotEmpty)
                Text(
                  text == ""
                      ? 'رَبَّنَا وَاجْعَلْنَا مُسْلِمَیْنِ لَكَ وَمِن ذُرِّیَّتِنَآ أُمَّةً مُّسْلِمَةً لَّكَ وَأَرِنَا مَنَاسِكَنَا وَتُبْ عَلَیْنَآ إِنَّكَ أَنتَ التَّوَّابُ الرَّحِیمُ'
                      : text!,
                  textAlign: TextAlign.end,
                  style: TextStyle(
                      // color: appColors.mainBrandingColor,
                      fontWeight: FontWeight.w500,
                      fontSize: fontProvider.fontSizeArabic.sp,
                      fontFamily: fontProvider.finalFont),
                ),
              if (translation != null && translation!.isNotEmpty)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      translation == "" ? '$translation' : translation!,
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: appColors.mainBrandingColor,
                        //fontSize: 11,
                        fontFamily: fontProvider.finalFont,
                        fontSize: fontProvider.fontSizeTrans.sp,
                      ),
                    ),
                    const SizedBox(height: 4), // Adjust the spacing here
                    if (ref != null && ref!.isNotEmpty)
                      Text(
                        '– $ref –',
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: appColors.mainBrandingColor,
                          // fontSize: 10,
                          fontFamily: fontProvider.finalFont,
                          fontSize: fontProvider.fontSizeTrans.sp,
                        ),
                      ),
                  ],
                ),
            ],
          );
        },
      ),
    );
  }
}
