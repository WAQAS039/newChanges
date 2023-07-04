import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nour_al_quran/pages/more/pages/tasbeeh/provider/tasbeeh_provider.dart';
import 'package:provider/provider.dart';

import '../../../../../shared/localization/localization_constants.dart';
import '../../../../../shared/localization/localization_provider.dart';
import '../../../../../shared/utills/app_colors.dart';
import '../../../../settings/pages/app_colors/app_colors_provider.dart';
import '../../../../settings/pages/app_them/them_provider.dart';
import 'counter_dialog.dart';

class CounterListSection extends StatelessWidget {
  const CounterListSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var appColors = Provider.of<AppColorsProvider>(context,listen: false);
    var language = Provider.of<LocalizationProvider>(context,listen: false);
    var them = Provider.of<ThemProvider>(context,listen: false);
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      clipBehavior: Clip.none,
      child: Consumer<TasbeehProvider>(
        builder: (context, tasbeehValue, child) {
          return Row(
            children: [
              Container(
                margin: EdgeInsets.only(left: language.locale.languageCode == "ur" || language.locale.languageCode =="ar" ? 5.w : 10.w ,right: language.locale.languageCode == "ur" || language.locale.languageCode =="ar" ? 20.w : 5.w),
                padding: EdgeInsets.only(right: 5.w),
                decoration: BoxDecoration(
                    color: them.isDark ? AppColors.darkColor : Colors.white,
                    borderRadius: BorderRadius.circular(21.5.r),
                    boxShadow: const [
                      BoxShadow(
                          offset: Offset(0, 4),
                          blurRadius: 12,
                          color: Color.fromRGBO(0, 0, 0, 0.08))
                    ]
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                      tasbeehValue.counterList.length, (index) {
                    return InkWell(
                      onTap: (){
                        tasbeehValue.setSelectedCounter(index);
                      },
                      child: Container(
                        margin: EdgeInsets.only(top: 2.h,bottom: 2.h),
                        child: CircleAvatar(
                          radius: 21.5.r,
                          backgroundColor: tasbeehValue.selectedCounter == index ? appColors.mainBrandingColor : Colors.transparent,
                          child: Text(tasbeehValue.counterList[index].toString(),style: TextStyle(fontWeight: FontWeight.w400,fontFamily: "satoshi",color: tasbeehValue.selectedCounter == index ? Colors.white : them.isDark ? Colors.white : Colors.black),),
                        ),
                      ),
                    );
                  }),
                ),
              ),
              InkWell(
                onTap: ()async{
                  await showCounterDialog(context, tasbeehValue, appColors);
                },
                child: Container(
                  margin: EdgeInsets.only(right: language.locale.languageCode == "ur" || language.locale.languageCode =="ar" ? 0: 20.w,left: language.locale.languageCode == "ur" || language.locale.languageCode =="ar" ? 20.w : 0),
                  padding: EdgeInsets.all(13.h),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: them.isDark ? AppColors.darkColor : Colors.white,
                      borderRadius: BorderRadius.circular(21.5.r),
                      boxShadow: const [
                        BoxShadow(
                            offset: Offset(0, 4),
                            blurRadius: 12,
                            color: Color.fromRGBO(0, 0, 0, 0.08))
                      ]
                  ),
                  child: Text(localeText(context, "custom_count"),style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontFamily: 'satoshi',
                    fontSize: 14.sp,
                  ),textAlign: TextAlign.center,
                  ),
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
