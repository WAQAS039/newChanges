import 'package:flutter/material.dart';
import 'package:nour_al_quran/shared/widgets/title_row.dart';
import 'package:nour_al_quran/pages/settings/pages/app_colors/app_colors_provider.dart';
import 'package:nour_al_quran/pages/settings/pages/fonts/font_provider.dart';
import 'package:nour_al_quran/shared/localization/localization_constants.dart';
import 'package:nour_al_quran/shared/utills/app_colors.dart';
import 'package:nour_al_quran/shared/widgets/brand_button.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nour_al_quran/shared/widgets/custom_track_shape.dart';
import 'package:provider/provider.dart';

import '../../../../shared/widgets/app_bar.dart';

class FontPage extends StatelessWidget {
  const FontPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var style = TextStyle(
        fontFamily: 'satoshi', fontSize: 14.sp, fontWeight: FontWeight.w500);
    Future.delayed(Duration.zero, () => context.read<FontProvider>().init());
    return Scaffold(
      appBar: buildAppBar(context: context, title: "Fonts"),
      body: Consumer2<FontProvider, AppColorsProvider>(
        builder: (context, fontProvider, appColors, child) {
          return SingleChildScrollView(
            child: Container(
              margin: EdgeInsets.only(left: 20.w, right: 20.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                      margin: EdgeInsets.only(
                        top: 30.h,
                        bottom: 18.h,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(localeText(context, 'arabic_font'),
                              style: style),
                          DropdownButton<String>(
                            value: fontProvider.currentFont,
                            underline: const SizedBox.shrink(),
                            onChanged: (String? newValue) {
                              fontProvider.setCurrentFont(newValue!);
                            },
                            items: fontProvider.fonts
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(
                                  value,
                                  style: style,
                                ),
                              );
                            }).toList(),
                          ),
                        ],
                      )),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        localeText(context, 'quran_text_size'),
                        style: TextStyle(
                            fontFamily: 'satoshi',
                            fontWeight: FontWeight.w500,
                            fontSize: 14.sp),
                      ),
                      Text(
                        '${fontProvider.fontSizeAr.toInt()} ${localeText(context, 'px')}',
                        style: TextStyle(
                            fontFamily: 'satoshi',
                            fontWeight: FontWeight.w500,
                            fontSize: 14.sp),
                      ),
                    ],
                  ),
                  SizedBox(height: 16.h),
                  SliderTheme(
                    data: SliderThemeData(
                        overlayShape: SliderComponentShape.noOverlay,
                        trackHeight: 8.h,
                        trackShape: CustomTrackShape()),
                    child: Slider(
                        value: fontProvider.fontSizeAr.toDouble(),
                        label: fontProvider.fontSizeAr.toString(),
                        min: 20.0,
                        max: 50.0,
                        activeColor: appColors.mainBrandingColor,
                        inactiveColor: AppColors.lightBrandingColor,
                        thumbColor: appColors.mainBrandingColor,
                        onChanged: (value) {
                          fontProvider.setFontSizeArabic(value.toDouble());
                        }),
                  ),
                  SizedBox(height: 22.h),
                  Text(
                    localeText(context, "arabic_font_preview"),
                    style: style,
                  ),
                  SizedBox(height: 10.h),
                  Container(
                    padding: EdgeInsets.all(10.h),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      'رَبَّنَآ ءَاتِنَا فِى ٱلدُّنْيَا حَسَنَةً وَفِى ٱلْءَاخِرَةِ حَسَنَةً وَقِنَا عَذَابَ ٱلنَّارِ',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontFamily: fontProvider.currentFont,
                          fontSize: fontProvider.fontSizeAr,
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                  SizedBox(height: 16.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        localeText(context, 'translation_text_size'),
                        style: style,
                      ),
                      Text(
                        '${fontProvider.fontSizeTrans.toInt()} ${localeText(context, "px")}',
                        style: style,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 16.h,
                  ),
                  SliderTheme(
                    data: SliderThemeData(
                        overlayShape: SliderComponentShape.noOverlay,
                        trackHeight: 8.h,
                        trackShape: CustomTrackShape()),
                    child: Slider(
                        value: fontProvider.fontSizeTrans.toDouble(),
                        label: fontProvider.fontSizeTrans.toString(),
                        min: 15.0,
                        max: 50.0,
                        activeColor: appColors.mainBrandingColor,
                        inactiveColor: AppColors.lightBrandingColor,
                        thumbColor: appColors.mainBrandingColor,
                        onChanged: (value) {
                          fontProvider.setFontSizeTranslation(value.toDouble());
                        }),
                  ),
                  SizedBox(
                    height: 16.h,
                  ),
                  Text(
                    localeText(context, 'translation_font_preview'),
                    style: style,
                  ),
                  Container(
                    padding: EdgeInsets.all(10.h),
                    margin: EdgeInsets.only(top: 10.h, bottom: 16.h),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      "the Path of those You have blessed—not those You are displeased with, or those who are astray.1",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontFamily: 'satoshi',
                          fontSize: fontProvider.fontSizeTrans,
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                  BrandButton(
                      text: localeText(context, "save_settings"),
                      onTap: () {
                        fontProvider.setFontSettings();
                        ScaffoldMessenger.of(context)
                          ..removeCurrentSnackBar()
                          ..showSnackBar(const SnackBar(
                            content: Text('Saved'),
                            duration: Duration(milliseconds: 500),
                          ));
                        Navigator.of(context).pop();
                      }),
                  SizedBox(
                    height: 20.h,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
