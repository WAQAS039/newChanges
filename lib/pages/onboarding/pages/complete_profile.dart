import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:hive/hive.dart';
import 'package:nour_al_quran/shared/localization/localization_constants.dart';
import 'package:nour_al_quran/shared/routes/routes_helper.dart';
import 'package:nour_al_quran/shared/utills/app_colors.dart';

import '../../../shared/utills/app_constants.dart';

class CompleteProfile extends StatelessWidget {
  const CompleteProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 2), () {
      // Hive.box(appBoxKey).put(onBoardingDoneKey, "done");
      // Navigator.of(context).pushNamedAndRemoveUntil(RouteHelper.application, (route) => false);
    });
    return Container(
      decoration: const BoxDecoration(
          color: AppColors.mainBrandingColor,
          image: DecorationImage(
              image: AssetImage('assets/images/splash/bg.webp'),
              fit: BoxFit.fill)),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Container(
          margin: EdgeInsets.only(left: 20.w, right: 20.w),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SpinKitSpinningLines(
                  color: Colors.white,
                  size: 50,
                ),
                SizedBox(
                  height: 10.h,
                ),
                Text(
                  localeText(context,
                      "please_be_patient_as_we_create_a_personalized_experience_for_your_quran_study"),
                  style: TextStyle(
                      fontFamily: 'satoshi',
                      fontSize: 16.sp,
                      color: Colors.white),
                  textAlign: TextAlign.center,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
