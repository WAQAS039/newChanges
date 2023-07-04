import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nour_al_quran/pages/more/pages/step_by_step_salah/salah_steps.dart';
import 'package:nour_al_quran/pages/more/pages/step_by_step_salah/salah_steps_provider.dart';
//import 'package:nour_al_quran/shared/widgets/title_row.dart';
import 'package:nour_al_quran/pages/settings/pages/app_colors/app_colors_provider.dart';
import 'package:nour_al_quran/pages/settings/pages/fonts/font_provider.dart';
import 'package:provider/provider.dart';

import '../../../../shared/utills/app_colors.dart';
import '../../../../shared/widgets/app_bar.dart';

class StepByStepSalahPage extends StatelessWidget {
  const StepByStepSalahPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    FontProvider fontProvider = Provider.of<FontProvider>(context);
    return Scaffold(
      appBar: buildAppBar(context: context, title: "Salah Steps"),
      body: Consumer2<SalahStepsProvider, AppColorsProvider>(
        builder: (context, value, appColors, child) {
          return ListView.builder(
            padding: EdgeInsets.only(top: 20.h, bottom: 20.h),
            itemCount: value.salahStepList.length,
            itemBuilder: (context, index) {
              SalahSteps salahSteps = value.salahStepList[index];
              return Container(
                padding: EdgeInsets.only(
                    left: 13.w, right: 12.w, top: 11.h, bottom: 16.h),
                margin: EdgeInsets.only(left: 20.w, right: 20.w, top: 12.h),
                decoration: BoxDecoration(
                    border: Border.all(color: AppColors.grey5),
                    borderRadius: BorderRadius.circular(6.r)),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(7.h),
                          margin: EdgeInsets.only(left: 11.w, right: 9.w),
                          decoration: BoxDecoration(
                              color: AppColors.lightBrandingColor,
                              borderRadius: BorderRadius.circular(6.r)),
                          child: Text(salahSteps.stepNumber!,
                              style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontFamily: 'satoshi',
                                  color: appColors.mainBrandingColor,
                                  fontSize:
                                      fontProvider.fontSizeTranslation.sp)),
                        ),
                        Text(salahSteps.title!,
                            style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontFamily: 'satoshi',
                                fontSize: fontProvider.fontSizeTranslation.sp))
                      ],
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 11.w, top: 8.h),
                      child: Text(
                        salahSteps.text!,
                        textAlign: TextAlign.justify,
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontFamily: 'satoshi',
                            fontSize: fontProvider.fontSizeTranslation.sp),
                      ),
                    )
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
