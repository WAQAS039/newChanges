import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nour_al_quran/pages/settings/pages/app_colors/app_colors_provider.dart';
import 'package:nour_al_quran/pages/settings/pages/app_them/them_provider.dart';
import 'package:nour_al_quran/pages/settings/pages/fonts/font_provider.dart';
import 'package:nour_al_quran/shared/entities/surah.dart';
import 'package:nour_al_quran/shared/utills/app_colors.dart';
import 'package:provider/provider.dart';

class DuaContainer extends StatelessWidget {
  final String? text;
  final String? translation;
  final String? ref;
  final String? verseId;

  final Surah? surahName;

  const DuaContainer({
    Key? key,
    this.text = "",
    this.translation = "",
    this.ref,
    this.verseId,
    this.surahName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final appColors = Provider.of<AppColorsProvider>(context);
    final isDark = Provider.of<ThemProvider>(context).isDark;

    return Container(
      width: double.maxFinite,
      decoration: BoxDecoration(
        color: isDark ? Colors.transparent : AppColors.grey6,
        borderRadius: BorderRadius.circular(6.r),
        border: Border.all(
          color: AppColors.grey5,
        ),
        // color: AppColors.grey5
      ),
      margin: EdgeInsets.only(left: 20.w, right: 20.w, bottom: 10.h),
      padding: EdgeInsets.only(left: 22.w, right: 22.w, top: 17.h, bottom: 9.h),
      child: Consumer<FontProvider>(
        builder: (context, fontProvider, child) {
          return Column(
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                    'Surah ' + (surahName?.surahName ?? '') + ' ($ref) ',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: appColors.mainBrandingColor,
                        fontWeight: FontWeight.w500,
                        fontSize: fontProvider.fontSizeTranslation.sp,
                        fontFamily: 'satoshi')),
              ),
              SizedBox(height: 10.h),
              Directionality(
                textDirection: TextDirection.rtl,
                child: RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    text: text == ""
                        ? 'رَبَّنَا وَاجْعَلْنَا مُسْلِمَیْنِ لَكَ وَمِن ذُرِّیَّتِنَآ أُمَّةً مُّسْلِمَةً لَّكَ وَأَرِنَا مَنَاسِكَنَا وَتُبْ عَلَیْنَآ إِنَّكَ أَنتَ التَّوَّابُ الرَّحِیمُ'
                        : '$text ',
                    style: TextStyle(
                      color: appColors.mainBrandingColor,
                      fontWeight: FontWeight.w500,
                      fontSize: fontProvider.fontSizeArabic.sp,
                      fontFamily: fontProvider.finalFont,
                    ),
                    children: <TextSpan>[
                      TextSpan(
                        text: '﴿ ',
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: fontProvider.fontSizeArabic.sp,
                          // Add any other desired styling properties
                        ),
                      ),
                      TextSpan(
                        text: convertToArabicNumber(int.parse(verseId!)),
                        style: TextStyle(
                          fontFamily: 'satoshi',
                          fontWeight: FontWeight.w700,
                          fontSize: fontProvider.fontSizeArabic.sp,
                          // Add any other desired styling properties
                        ),
                      ),
                      TextSpan(
                        text: ' ﴾',
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: fontProvider.fontSizeArabic.sp,
                          // Add any other desired styling properties
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Text('– $ref –',
              //     textAlign: TextAlign.center,
              //     style: TextStyle(
              //         color: appColors.mainBrandingColor,
              //         fontWeight: FontWeight.w500,
              //         fontSize: fontProvider.fontSizeTranslation.sp,
              //         fontFamily: 'satoshi')),
              SizedBox(
                height: 12.h,
              ),
              Text('$translation',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: fontProvider.fontSizeTranslation.sp,
                      fontFamily: 'satoshi'))
            ],
          );
        },
      ),
    );
  }
}

String convertToArabicNumber(int? verseId) {
  if (verseId == null) {
    return '';
  }

  const List<String> arabicNumbers = [
    '٠',
    '١',
    '٢',
    '٣',
    '٤',
    '٥',
    '٦',
    '٧',
    '٨',
    '٩'
  ];

  if (verseId == 0) {
    return arabicNumbers[0];
  }

  String arabicNumeral = '';
  int id = verseId;

  while (id > 0) {
    int digit = id % 10;
    arabicNumeral = arabicNumbers[digit] + arabicNumeral;
    id ~/= 10;
    // print('Digit: $digit, Arabic Numeral: $arabicNumeral');
  }

  return arabicNumeral;
}
