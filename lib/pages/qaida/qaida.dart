import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nour_al_quran/pages/settings/pages/app_colors/app_colors_provider.dart';
import 'package:nour_al_quran/shared/utills/app_colors.dart';
import 'package:nour_al_quran/shared/widgets/title_text.dart';
import 'package:provider/provider.dart';

class QaidaPage extends StatelessWidget {
  const QaidaPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
              margin: EdgeInsets.only(left: 20.w, top: 60.h,bottom: 12.h,right: 20.w),
              child: const TitleText(title: "Qaida",)),
          Expanded(
            child: MediaQuery.removePadding(
              context: context,
              removeTop: true,
              child: ListView.builder(
                itemCount: 5,
                  itemBuilder: (context, index) {
                    return Container(
                      // height: 54.h,
                      margin: EdgeInsets.only(left: 20.w,right: 20.w,bottom: 10.h),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6.r),
                        border: Border.all(color: AppColors.grey4),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            margin: EdgeInsets.only(left: 10.w,top: 19.h,bottom: 19.h,right: 10.w),
                            child: Text("Lesson 01",style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 12.sp,
                              fontFamily: "satoshi",
                              // color: AppColors.grey2
                            ),),
                          ),
                          Consumer<AppColorsProvider>(
                            builder: (context, colors, child) {
                              return Container(
                              height: 27.h,
                              width: 27.w,
                              margin: EdgeInsets.only(right: 10.w, top: 17.h, bottom: 16.h,left: 10.w),
                              child: CircleAvatar(
                                backgroundColor: colors.mainBrandingColor,
                                child: Icon(
                                  Icons.arrow_forward_ios,
                                  color: Colors.white,
                                  size: 9.h,
                                ),
                              ),
                            );
                              },)
                        ],
                      ),
                    );
                  },),
            ),
          ),
        ],
      ),
    );
  }
}
