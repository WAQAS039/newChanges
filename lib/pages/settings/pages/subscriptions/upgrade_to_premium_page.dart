import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nour_al_quran/pages/settings/pages/app_colors/app_colors_provider.dart';
import 'package:nour_al_quran/pages/settings/pages/app_them/them_provider.dart';
import 'package:nour_al_quran/shared/utills/app_colors.dart';
import 'package:nour_al_quran/shared/widgets/brand_button.dart';
import 'package:provider/provider.dart';

import '../../../../shared/widgets/app_bar.dart';

class UpgradeToPremiumPage extends StatelessWidget {
  const UpgradeToPremiumPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: buildAppBar(context: context, title: "Upgrade to Premium"),
        body: Consumer2<ThemProvider, AppColorsProvider>(
          builder: (context, them, appColors, child) {
            return SingleChildScrollView(
              child: Container(
                margin: EdgeInsets.only(left: 20.w, right: 20.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.only(bottom: 5.h),
                      child: Text(
                        'Get the premium today and enjoy unlimited access to the Quran App',
                        style: TextStyle(
                            color: them.isDark ? AppColors.grey5 : Colors.black,
                            fontFamily: 'satoshi',
                            fontWeight: FontWeight.w500,
                            fontSize: 12.sp),
                      ),
                    ),
                    _buildUnlockContainer('Ad-free App Experience', them),
                    _buildUnlockContainer('Unlock Quran Stories', them),
                    _buildUnlockContainer('Unlock Quran Stories', them),
                    Container(
                        margin: EdgeInsets.only(top: 16.h, bottom: 16.h),
                        child: Text(
                          'Available Plans for You',
                          style: TextStyle(
                              fontFamily: 'satoshi',
                              fontWeight: FontWeight.w900,
                              fontSize: 18.sp),
                        )),
                    Container(
                      width: double.maxFinite,
                      margin: EdgeInsets.only(bottom: 20.h),
                      padding: EdgeInsets.only(
                          left: 11.w, right: 15.w, top: 13.h, bottom: 13.h),
                      decoration: BoxDecoration(
                        color: them.isDark
                            ? AppColors.darkColor
                            : appColors.mainBrandingColor,
                        borderRadius: BorderRadius.circular(6.r),
                        border: Border.all(color: AppColors.grey3),
                      ),
                      child: Row(
                        children: [
                          Container(
                              margin: EdgeInsets.only(right: 11.w),
                              child: const Icon(
                                Icons.check_circle,
                                color: Colors.white,
                              )),
                          Expanded(
                            // Wrap the Row widget inside Expanded
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Text(
                                      'Monthly Plan',
                                      style: TextStyle(
                                          fontSize: 16.sp,
                                          fontFamily: 'satoshi',
                                          fontWeight: FontWeight.w700),
                                    ),
                                    Text('800 PKR',
                                        style: TextStyle(
                                            fontSize: 16.sp,
                                            fontFamily: 'satoshi',
                                            fontWeight: FontWeight.w700)),
                                  ],
                                ),
                                SizedBox(
                                  height: 2.h,
                                ),
                                Text('3 day free trial + restore purchase',
                                    style: TextStyle(
                                        fontSize: 12.sp,
                                        fontFamily: 'satoshi',
                                        fontWeight: FontWeight.w700)),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Container(
                    //   width: double.maxFinite,
                    //   margin: EdgeInsets.only(left: 20.w,right: 20.w),
                    //   padding: EdgeInsets.only(left: 11.w,right: 15.w,top: 13.h,bottom: 13.h),
                    //   decoration: BoxDecoration(
                    //     color: appColors.mainBrandingColor,
                    //     borderRadius: BorderRadius.circular(6.r),
                    //     border: Border.all(color: Colors.grey),
                    //   ),
                    //   child: Container(
                    //     color: Colors.red,
                    //     child: Row(
                    //       mainAxisSize: MainAxisSize.max,
                    //       children: [
                    //         const Icon(Icons.check_circle,color: Colors.white,),
                    //         Container(
                    //           color: Colors.red,
                    //           child: Column(
                    //             crossAxisAlignment: CrossAxisAlignment.start,
                    //             children: [
                    //               Container(
                    //                 color:Colors.amber,
                    //                 child: Row(
                    //                   mainAxisSize: MainAxisSize.max,
                    //                   children: [
                    //                     Text('Monthly Plan'),
                    //                     Text('800 PKR'),
                    //                   ],
                    //                 ),
                    //               ),
                    //               Text('3 day free trial + restore purchase'),
                    //             ],
                    //           ),
                    //         ),
                    //       ],
                    //     ),
                    //   ),
                    // ),
                    BrandButton(text: 'Purchase', onTap: () {}),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 18.0),
                      child: Container(
                        width: double.maxFinite,
                        margin: EdgeInsets.only(bottom: 16.h),
                        child: Text(
                          'Start Free Trial',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: appColors.mainBrandingColor,
                              fontFamily: 'satoshi',
                              fontWeight: FontWeight.w500,
                              fontSize: 12.sp),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            );
          },
        ));
  }

  Container _buildUnlockContainer(String title, ThemProvider them) {
    return Container(
        width: double.maxFinite,
        margin: EdgeInsets.only(top: 12.h),
        padding: EdgeInsets.only(left: 11.5.w, top: 14.h, bottom: 14.h),
        decoration: BoxDecoration(
            color: them.isDark ? AppColors.darkColor : AppColors.grey6,
            borderRadius: BorderRadius.circular(6.r)),
        child: Row(
          children: [
            Container(
                margin: EdgeInsets.only(right: 9.5.w),
                child: Image.asset(
                  'assets/images/app_icons/unlock.png',
                  height: 18.33.h,
                  width: 15.w,
                )),
            Text(
              title,
              style: TextStyle(
                  fontFamily: 'satoshi',
                  fontWeight: FontWeight.w500,
                  fontSize: 12.sp),
            ),
          ],
        ));
  }
}
