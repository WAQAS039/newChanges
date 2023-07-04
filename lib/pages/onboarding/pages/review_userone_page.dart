import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nour_al_quran/pages/settings/pages/app_them/them_provider.dart';
import 'package:nour_al_quran/shared/localization/localization_constants.dart';
import 'package:nour_al_quran/shared/routes/routes_helper.dart';
import 'package:nour_al_quran/shared/utills/app_colors.dart';
import 'package:nour_al_quran/shared/widgets/brand_button.dart';
import 'package:provider/provider.dart';

class ReviewOne extends StatelessWidget {
  const ReviewOne({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var isDark = context.read<ThemProvider>().isDark;
    return Container(
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage(
                'assets/images/arabic_man.webp',
              ),
              fit: BoxFit.cover)),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: [
            _buildGradientContainer(context),
            _buildReviewContainer(isDark, context)
          ],
        ),
      ),
    );
  }

  Positioned _buildGradientContainer(BuildContext context) {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Opacity(
        opacity: 0.4,
        child: Container(
          alignment: Alignment.bottomCenter,
          height: MediaQuery.of(context).size.height * 0.5,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.center,
              end: Alignment.bottomCenter,
              colors: [
                Color.fromRGBO(0, 0, 0, 0),
                Color.fromRGBO(0, 0, 0, 100),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Container _buildReviewContainer(bool isDark, BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 20.w, right: 20.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 0.40, sigmaY: 0.40),
            child: Container(
              margin: EdgeInsets.only(bottom: 20.h),
              padding: EdgeInsets.only(
                  left: 11.w, right: 10.w, top: 19.h, bottom: 17.h),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16.r),
                  backgroundBlendMode: BlendMode.luminosity,
                  color:
                      isDark ? Colors.black : AppColors.reviewContainerColor),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Best offline Al-Quran reading app so far because it's so easy to use even for an app dummy. Even more it caters most of the stuff you need to know about Al-Quran for Muslims & non-Muslims alike. I'd pray for their ( devs & team) kindness contribution for this marvellous app. Jazaakumullahi khairan.",
                    style: TextStyle(
                        fontFamily: 'satoshi',
                        fontWeight: FontWeight.w500,
                        fontSize: 14.sp),
                    textAlign: TextAlign.justify,
                  ),
                  Container(
                      margin: EdgeInsets.only(top: 9.57.h, bottom: 5.07.h),
                      child: Row(
                        children: List.generate(
                            5,
                            (index) => const Icon(
                                  Icons.star_rounded,
                                  color: Colors.orange,
                                )),
                      )),
                  Text(
                    "Moeed Shahid",
                    style: TextStyle(
                        fontFamily: 'satoshi',
                        fontWeight: FontWeight.w700,
                        fontSize: 18.sp),
                  )
                ],
              ),
            ),
          ),
          BrandButton(
              text: localeText(context, "continue"),
              onTap: () {
                Navigator.of(context).pushNamed(RouteHelper.paywallscreen);
              }),
          SizedBox(
            height: 50.h,
          )
        ],
      ),
    );
  }
}
