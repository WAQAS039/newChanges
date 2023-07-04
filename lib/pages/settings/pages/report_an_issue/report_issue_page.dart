import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nour_al_quran/shared/localization/localization_constants.dart';
import 'package:nour_al_quran/shared/utills/app_colors.dart';
import 'package:nour_al_quran/shared/widgets/brand_button.dart';
import 'package:nour_al_quran/shared/widgets/title_row.dart';

import '../../../../shared/widgets/app_bar.dart';

class ReportIssuePage extends StatelessWidget {
  const ReportIssuePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var style14 = TextStyle(fontFamily: 'satoshi',fontSize: 14.sp,fontWeight: FontWeight.w400);
    return Scaffold(
      appBar: buildAppBar(context: context,title: localeText(context, "report_an_issue")),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(left: 20.h,right: 20.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Please let us know what you’d like to do",style: style14,),
              Container(
                margin: EdgeInsets.only(top: 7.h,bottom: 13.h),
                padding: EdgeInsets.only(left: 10.w,right: 21.w),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6.r),
                  border: Border.all(color: AppColors.grey5)
                ),
                child:  Theme(
                  data: ThemeData(dividerColor: Colors.transparent),
                  child: ExpansionTile(
                    title: Text("Request a Feature",style: style14,),
                    tilePadding: EdgeInsets.zero,
                    childrenPadding: EdgeInsets.zero,
                    expandedCrossAxisAlignment: CrossAxisAlignment.center,
                    expandedAlignment: Alignment.centerLeft,
                    children: [
                      Container(
                          width: double.maxFinite,
                          margin: EdgeInsets.only(bottom: 2.h),
                          padding: EdgeInsets.all(10.h),
                          color: AppColors.grey5,
                          child: Text("Request a Feature",style: style14,)),
                      Container(
                          width: double.maxFinite,
                          padding: EdgeInsets.all(10.h),
                          margin: EdgeInsets.only(bottom: 2.h),
                          color: AppColors.grey5,
                          child: Text("Request a Feature",style: style14,)),
                      Container(
                          width: double.maxFinite,
                          padding: EdgeInsets.all(10.h),
                          margin: EdgeInsets.only(bottom: 2.h),
                          color: AppColors.grey5,
                          child: Text("Request a Feature",style: style14,)),
                    ],
                  ),
                )
              ),
              Text("Description",style: style14,),
              Container(
                  margin: EdgeInsets.only(top: 7.h),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6.r),
                      border: Border.all(color: AppColors.grey5)
                  ),
                  child: TextField(
                    maxLines: 8,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.only(top: 13.h,left: 10.w,right: 10.w,bottom: 13.h),
                      hintText: "Add details",
                      hintStyle: style14,
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      border: InputBorder.none,
                    ),
                  )),
              Container(
                  margin: EdgeInsets.only(top: 10.h,bottom: 10.h),
                  child: Text("Your Email",style: style14,)),
              TextField(
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: AppColors.grey5),
                    borderRadius: BorderRadius.circular(6.r),
                  ),
                  border: OutlineInputBorder(
                    borderSide: const BorderSide(color: AppColors.grey5),
                    borderRadius: BorderRadius.circular(6.r),
                  )
                ),
              ),
              Container(
                  margin: EdgeInsets.only(top: 10.h,bottom: 10.h),
                  child: BrandButton(text: "Submit", onTap: (){}))
            ],
          ),
        ),
      ),
    );
  }
}
