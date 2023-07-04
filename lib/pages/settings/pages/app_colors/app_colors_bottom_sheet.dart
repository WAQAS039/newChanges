import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nour_al_quran/pages/settings/pages/app_colors/app_colors_provider.dart';
import 'package:nour_al_quran/shared/localization/localization_constants.dart';
import 'package:nour_al_quran/shared/utills/app_colors.dart';
import 'package:nour_al_quran/shared/widgets/brand_button.dart';
import 'package:provider/provider.dart';


int color = 0xFF27AE60;
List<Color> appColorsList = [
  const Color(0xFF27AE60),
  const Color(0xFFEB5757),
  const Color(0xFFF2C94C),
  const Color(0xFFF2994A),
  const Color(0xFFCC9F00),
  const Color(0xFF2F80ED),
  const Color(0xFF2D9CDB),
  const Color(0xFF9B51E0),
  const Color(0xFFBB6BD9),
  const Color(0xFFA90303),
  const Color(0xFF218555),
  const Color(0xFFD46565),
  const Color(0xFF1EE8CF),
  const Color(0xFF8BAE27),
  const Color(0xFF2745AE),
  const Color(0xFF27A6AE),
  const Color(0xFFAE2788),
];

void showImagesBottomSheet(BuildContext context) {
  Color selectedColor = appColorsList[0];
  showModalBottomSheet(
    context: context,
    isDismissible: true,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.only(topLeft: Radius.circular(10.r),topRight: Radius.circular(10.r)),
    ),
    builder: (context) {
      return SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(left: 20.w,right: 20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                height: 6.h,
                width: 131.w,
                margin: EdgeInsets.only(top: 13.h),
                decoration: BoxDecoration(
                  color: AppColors.grey3,
                  borderRadius: BorderRadius.circular(2.5.r)
                ),
              ),
              Container(
                width: double.maxFinite,
                margin: EdgeInsets.only(top: 18.h),
                alignment: Alignment.centerLeft,
                child: Text(localeText(context, 'choose_app_color'),style: TextStyle(fontSize: 16.sp,fontFamily: "satoshi",fontWeight: FontWeight.w700),),
              ),
              GridView.builder(
                  itemCount: appColorsList.length,
                  padding: EdgeInsets.only(top: 13.h,bottom: 21.h),
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 34.h,
                      mainAxisSpacing: 19.h,
                      crossAxisSpacing: 19.w
                  ),
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: (){
                        selectedColor = appColorsList[index];
                        context.read<AppColorsProvider>().setSelectedColor(appColorsList[index]);
                      },
                      child: Container(
                          height: 34.h,
                          width: 34.w,
                          decoration: BoxDecoration(
                            color: appColorsList[index],
                            borderRadius: BorderRadius.circular(30.r)
                          ),
                        child: Consumer<AppColorsProvider>(
                          builder: (context, value, child) {
                            return value.selectedColor == appColorsList[index] ? const Icon(Icons.check,color: Colors.white,) : const SizedBox.shrink();
                          },
                        ),
                      ),
                    );
                  },),
              BrandButton(text: localeText(context, "update_colors"), onTap: (){
                context.read<AppColorsProvider>().setMainBrandingColor(selectedColor,selectedColor.value);
                Navigator.of(context).pop();
              }),
              SizedBox(height: 30.h,),
            ],
          ),
        ),
      );
    },);
}
