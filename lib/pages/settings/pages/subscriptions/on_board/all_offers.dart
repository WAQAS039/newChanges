import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nour_al_quran/shared/widgets/title_row.dart';
import 'package:nour_al_quran/pages/settings/pages/app_colors/app_colors_provider.dart';
import 'package:nour_al_quran/shared/utills/app_colors.dart';
import 'package:nour_al_quran/shared/widgets/brand_button.dart';
import 'package:provider/provider.dart';

import '../../../../../shared/widgets/app_bar.dart';

class AllOffers extends StatelessWidget {
  const AllOffers({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var style12 = TextStyle(fontFamily: 'satoshi',fontWeight: FontWeight.w400,fontSize: 12.sp);
    var appColor = context.read<AppColorsProvider>().mainBrandingColor;
    return Scaffold(
      appBar: buildAppBar(context: context,title: "Upgrade to Premium"),
      body: Container(
        margin: EdgeInsets.only(left: 20.w,right: 20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
                margin: EdgeInsets.only(top: 6.h,bottom: 12.h),
                child: Text("Get the premium today and enjoy unlimited access to the Quran App",style: style12,textAlign: TextAlign.center,)),
            Container(
              margin: EdgeInsets.only(bottom: 20.h),
              padding: EdgeInsets.only(top: 14.h,left: 20.w,right: 20.w,bottom: 14.h),
              decoration: BoxDecoration(
                color: appColor,
                borderRadius: BorderRadius.circular(16.r)
              ),
              child: Column(
                children: [
                  Text("Limited Time Offer for Unlimited Perks & Benefits",
                    style: TextStyle(fontFamily: 'satoshi',fontWeight: FontWeight.w600,fontSize: 16.sp,color: Colors.white),
                    textAlign: TextAlign.center,),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 7.h,horizontal: 19.w),
                    margin: EdgeInsets.only(top: 12.h),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(14.r)
                    ),
                    child: Text('Ends in 14:32:56',style: TextStyle(fontFamily: 'satoshi',fontWeight: FontWeight.w400,fontSize: 12.sp,color: appColor),),
                  )
                ],
              ),
            ),
            Text("Plans specially curated for you",style: TextStyle(fontFamily: 'satoshi',fontWeight: FontWeight.w400,fontSize: 16.sp),),
            Container(
              margin: EdgeInsets.only(top: 15.h,bottom: 20.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Monthly',style: style12,),
                  Container(
                      height: 20.h,
                      width: 36.w,
                      margin: EdgeInsets.only(left: 9.w,right: 9.w,),
                      child: FittedBox(
                          fit: BoxFit.fill,
                          child: CupertinoSwitch(value: false, onChanged: (value){}))),
                  Text('Yearly',style: style12,),
                ],
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.only(top: 7.94.h,bottom: 12.h,left: 12.w,right: 12.w),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4.4.r),
                        border: Border.all(color: AppColors.grey4)
                    ),
                    child: Column(
                      children: [
                        Text('6 Months',style: TextStyle(fontFamily: 'satoshi',fontWeight: FontWeight.w400,fontSize: 8.sp),),
                        SizedBox(height: 7.48.h,),
                        Text("\$21.56",style: TextStyle(fontFamily: 'satoshi',fontWeight: FontWeight.w400,fontSize: 17.sp),),
                        SizedBox(height: 2.88.h,),
                        Text("(\$3.59 per month)",style: TextStyle(fontFamily: 'satoshi',fontWeight: FontWeight.w400,fontSize: 8.87.sp),),
                        Container(
                          margin: EdgeInsets.only(top: 7.69.h),
                          padding: EdgeInsets.symmetric(vertical: 1.7.h,horizontal: 5.w),
                          decoration: BoxDecoration(
                            color: appColor,
                            borderRadius: BorderRadius.circular(7.r)
                          ),
                          child: Text('Save 39%',style: TextStyle(fontFamily: 'satoshi',fontWeight: FontWeight.w400,fontSize: 8.sp,color: Colors.white),),
                        )
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.only(top: 7.94.h,bottom: 12.h,left: 12.w,right: 12.w),
                    decoration: BoxDecoration(
                      color: AppColors.primeBlue,
                        borderRadius: BorderRadius.circular(4.4.r),
                        border: Border.all(color: AppColors.grey4)
                    ),
                    child: Column(
                      children: [
                        Text('6 Months',style: TextStyle(fontFamily: 'satoshi',fontWeight: FontWeight.w400,fontSize: 8.sp,color: Colors.white),),
                        SizedBox(height: 7.48.h,),
                        Text("\$21.56",style: TextStyle(fontFamily: 'satoshi',fontWeight: FontWeight.w400,fontSize: 17.sp,color: Colors.white),),
                        SizedBox(height: 2.88.h,),
                        Text("(\$3.59 per month)",style: TextStyle(fontFamily: 'satoshi',fontWeight: FontWeight.w400,fontSize: 8.87.sp,color: Colors.white),),
                        Container(
                          margin: EdgeInsets.only(top: 7.69.h),
                          padding: EdgeInsets.symmetric(vertical: 1.7.h,horizontal: 5.w),
                          decoration: BoxDecoration(
                              color: appColor,
                              borderRadius: BorderRadius.circular(7.r)
                          ),
                          child: Text('Save 39%',style: TextStyle(fontFamily: 'satoshi',fontWeight: FontWeight.w400,fontSize: 8.sp,color: Colors.white),),
                        )
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.only(top: 7.94.h,bottom: 12.h,left: 12.w,right: 12.w),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4.4.r),
                        border: Border.all(color: AppColors.grey4)
                    ),
                    child: Column(
                      children: [
                        Text('6 Months',style: TextStyle(fontFamily: 'satoshi',fontWeight: FontWeight.w400,fontSize: 8.sp),),
                        SizedBox(height: 7.48.h,),
                        Text("\$21.56",style: TextStyle(fontFamily: 'satoshi',fontWeight: FontWeight.w400,fontSize: 17.sp),),
                        SizedBox(height: 2.88.h,),
                        Text("(\$3.59 per month)",style: TextStyle(fontFamily: 'satoshi',fontWeight: FontWeight.w400,fontSize: 8.87.sp),),
                        Container(
                          margin: EdgeInsets.only(top: 7.69.h),
                          padding: EdgeInsets.symmetric(vertical: 1.7.h,horizontal: 5.w),
                          decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(7.r)
                          ),
                          child: Text('No Discount',style: TextStyle(fontFamily: 'satoshi',fontWeight: FontWeight.w400,fontSize: 8.sp,color: Colors.white),),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Container(
              margin: EdgeInsets.only(top: 20.h,bottom: 14.h),
              padding: EdgeInsets.only(top: 17.h,left: 15.w,right: 15.w,bottom: 15.h),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6.r),
                border: Border.all(color: AppColors.grey5)
              ),
              child: Column(
                children: [
                  Text("Prime Plan",style: TextStyle(fontFamily: 'satoshi',fontWeight: FontWeight.w400,fontSize: 14.sp),),
                  Row(
                    children: [
                      Icon(Icons.check_circle,color: AppColors.primeBlue,),
                      Text('No ads',style: style12,)
                    ],
                  ),
                  Row(
                    children: [
                      Icon(Icons.check_circle,color: AppColors.primeBlue,),
                      Text('No ads',style: style12,)
                    ],
                  ),
                  Row(
                    children: [
                      Icon(Icons.check_circle,color: AppColors.primeBlue,),
                      Text('No ads',style: style12,)
                    ],
                  ),
                  Row(
                    children: [
                      Icon(Icons.check_circle,color: AppColors.primeBlue,),
                      Text('No ads',style: style12,)
                    ],
                  ),
                ],
              ),
            ),
            BrandButton(text: "Purchase Now", onTap: (){}),
            Text(
              'Recurring Billing, Cancel Anytime.\nYour subscription will automatically renew for the same purchasing program at the same time',
            style: TextStyle(fontSize: 10.sp,fontFamily: 'satoshi',fontWeight: FontWeight.w400),
            textAlign: TextAlign.center,),

          ],
        ),
      ),
    );
  }
}
