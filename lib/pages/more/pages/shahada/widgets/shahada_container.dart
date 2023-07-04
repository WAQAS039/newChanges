import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nour_al_quran/pages/settings/pages/fonts/font_provider.dart';
import 'package:provider/provider.dart';

import '../../../../../shared/localization/localization_constants.dart';
import '../../../../../shared/utills/app_colors.dart';
import '../../../../settings/pages/app_colors/app_colors_provider.dart';
import '../../../../settings/pages/app_them/them_provider.dart';

class ShahadaContainer extends StatelessWidget {
  const ShahadaContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer3<AppColorsProvider,ThemProvider,FontProvider>(
      builder: (context, appColors,them,fontProvider, child) {
        return Container(
          margin: EdgeInsets.only(left: 20.w,right: 20.w,top: 35.h,bottom: 20.w),
          padding: EdgeInsets.only(top: 11.h,bottom: 16.h,left: 18.w,right: 18.w),
          decoration: BoxDecoration(
              color: them.isDark ? AppColors.darkColor : Colors.white,
              boxShadow: const[
                BoxShadow(
                    offset: Offset(0,5),
                    blurRadius: 15,
                    color: Color.fromRGBO(0, 0, 0, 0.12)
                )
              ],
              borderRadius: BorderRadius.circular(8.r)
          ),
          child: Column(
            children: [
              Text(localeText(context, "1st_shahadah_purity"),
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 12.sp,
                    color: appColors.mainBrandingColor,
                    fontWeight: FontWeight.w700,
                    fontFamily: 'satoshi'),),
              SizedBox(height: 11.h,),
              Text("اَشْهَدُ اَنْ لَّآ اِلٰهَ اِلَّا اللهُ وَحْدَہٗ لَاشَرِيْكَ لَہٗ وَاَشْهَدُ اَنَّ مُحَمَّدًا عَبْدُهٗ وَرَسُولُہٗ",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: fontProvider.fontSizeArabic.sp,
                    fontFamily: fontProvider.finalFont,
                    fontWeight: FontWeight.w400),),
              SizedBox(height: 13.h,),
              Text('I bear witness that there is none worthy of worship except Allah, and I bear witness that Muhammad is His servant and his Messenger.',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: fontProvider.fontSizeTranslation.sp,
                    color: them.isDark ? AppColors.grey4 : AppColors.grey3,
                    fontWeight: FontWeight.w500,
                    fontFamily: 'satoshi'),)
            ],
          ),
        );
      },
    );
  }
}
