import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nour_al_quran/shared/widgets/title_row.dart';
import 'package:nour_al_quran/pages/settings/pages/app_colors/app_colors_provider.dart';
import 'package:nour_al_quran/pages/settings/pages/app_them/them_provider.dart';
import 'package:nour_al_quran/shared/localization/localization_constants.dart';
import 'package:nour_al_quran/shared/utills/app_colors.dart';
import 'package:provider/provider.dart';

import '../../../../shared/widgets/app_bar.dart';

class AppThemPage extends StatefulWidget {
  const AppThemPage({Key? key}) : super(key: key);

  @override
  State<AppThemPage> createState() => _AppThemPageState();
}

class _AppThemPageState extends State<AppThemPage> {
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
    bool isDark = context.read<ThemProvider>().isDark;
    if(isDark){
      currentIndex = 1;
    }
  }
  @override
  Widget build(BuildContext context) {
    var appColors = context.read<AppColorsProvider>().mainBrandingColor;
    return Scaffold(
      appBar: buildAppBar(context: context,title: localeText(context,"app_theme")),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 141.h,
              width: 141.w,
              margin: EdgeInsets.only(top: 50.h),
              child: CircleAvatar(
                backgroundColor: currentIndex == 0? Colors.amber :Colors.transparent,
                child: currentIndex == 0 ? const SizedBox.shrink():Image.asset('assets/images/dark.png'),
              ),
            ),
            SizedBox(height: 30.h,),
            Text(localeText(context,'choose_app_theme'),style: TextStyle(
              fontFamily: 'satoshi',
              fontSize: 18.sp,
              fontWeight: FontWeight.w900
            ),),
            SizedBox(height: 8.h,),
            Text(localeText(context,'customize_the_app_experience'),style: TextStyle(
                fontFamily: 'satoshi',
                fontSize: 14.sp,
                fontWeight: FontWeight.w900,
              color: AppColors.grey2
            ),),
            SizedBox(height: 20.h,),
            Container(
              height: 46.h,
              margin: EdgeInsets.only(left: 46.w,right: 46.w),
              decoration: BoxDecoration(
                color: Colors.white,
                  borderRadius: BorderRadius.circular(23.r),
                border: Border.all(color: AppColors.grey5)
              ),
              child: Consumer(
                builder: (context, value, child) {
                  return Row(
                      children: List.generate(2, (index) {
                        return Expanded(
                          child: InkWell(
                            onTap: (){
                              if(index == 0){
                                context.read<ThemProvider>().setToDark(false);
                              }else{
                                context.read<ThemProvider>().setToDark(true);
                              }
                              setState(() {
                                currentIndex = index;
                              });
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  color: index == currentIndex ? appColors : Colors.white,
                                  borderRadius: BorderRadius.circular(23.02.r)
                              ),
                              child: Center(child: Text(index == 0 ? localeText(context, "light_mode") : localeText(context, 'dark_mode'),style: TextStyle(fontSize: 11.94.sp,color: index==currentIndex ? Colors.white : Colors.black,fontFamily: 'satoshi'),)),
                            ),
                          ),
                        );
                      })
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
