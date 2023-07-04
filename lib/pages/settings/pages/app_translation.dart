import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nour_al_quran/shared/widgets/title_row.dart';
import 'package:nour_al_quran/pages/settings/pages/app_colors/app_colors_provider.dart';
import 'package:nour_al_quran/shared/localization/languages.dart';
import 'package:nour_al_quran/shared/localization/localization_constants.dart';
import 'package:nour_al_quran/shared/localization/localization_provider.dart';
import 'package:nour_al_quran/shared/utills/app_colors.dart';
import 'package:provider/provider.dart';

import '../../../shared/widgets/app_bar.dart';

class AppTranslationPage extends StatelessWidget {
  const AppTranslationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var appColors = context.read<AppColorsProvider>().mainBrandingColor;
    return Scaffold(
      appBar: buildAppBar(context: context,title: localeText(context, "app_language")),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: Languages.languages.length,
                itemBuilder: (context, index) {
                Languages lang = Languages.languages[index];
                  return Container(
                    margin: EdgeInsets.only(left: 20.w,right: 20.w,bottom: 10.h),
                    decoration: BoxDecoration(
                      border: Border.all(color: AppColors.grey5,),
                      borderRadius: BorderRadius.circular(6.r),
                    ),
                    child: InkWell(
                      onTap: (){
                        context.read<LocalizationProvider>().setLocale(lang);
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Container(
                                margin: EdgeInsets.only(top: 11.h,left: 10.w,bottom: 10.h,right: 9.w),
                                height: 33.h,
                                width: 33.w,
                                decoration: BoxDecoration(
                                    image: DecorationImage(image: AssetImage('assets/images/flags/${lang.flag}.png')),
                                    borderRadius: BorderRadius.circular(6.r)
                                ),),
                              Text(localeText(context, lang.name),style: TextStyle(fontSize: 12.sp,fontWeight: FontWeight.w700))
                            ],
                          ),
                          Consumer<LocalizationProvider>(
                            builder: (context, value, child) {
                              return Container(
                                  margin: EdgeInsets.only(right: 10.w,left: 10.w),
                                  child: Icon(value.locale.languageCode == lang.languageCode ? Icons.check_circle : Icons.check_circle_outline,size: 15.h,color: appColors,));
                            },
                          ),
                        ],
                      ),
                    ),
                  );
                },),
          )
        ],
      ),
    );
  }
}
