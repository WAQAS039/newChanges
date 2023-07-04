import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nour_al_quran/pages/more/pages/tasbeeh/provider/tasbeeh_provider.dart';
import 'package:nour_al_quran/pages/more/pages/tasbeeh/widgets/counter_list_section.dart';
import 'package:nour_al_quran/pages/more/pages/tasbeeh/widgets/finger_print_section.dart';
import 'package:nour_al_quran/pages/more/pages/tasbeeh/widgets/tasbeeh_list_section.dart';
import 'package:nour_al_quran/pages/settings/pages/app_colors/app_colors_provider.dart';
import 'package:nour_al_quran/shared/localization/localization_constants.dart';
import 'package:nour_al_quran/pages/settings/pages/app_them/them_provider.dart';
import 'package:nour_al_quran/shared/utills/app_colors.dart';
import 'package:provider/provider.dart';


import '../../../../../shared/widgets/app_bar.dart';

class TasbeehPage extends StatelessWidget {
  const TasbeehPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var appColors = Provider.of<AppColorsProvider>(context,listen: false);
    var them = Provider.of<ThemProvider>(context,listen: false);
    return Scaffold(
      appBar: buildAppBar(context: context,title: localeText(context, "tasbeeh")),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const TasbeehListSection(),
            _buildOtherTasbeehContainer(them, appColors, context),
            const CounterListSection(),
            const FingerPrintSection(),
            _buildSoundResetButtons(appColors),
          ],
        ),
      ),
    );
  }




  _buildSoundResetButtons(AppColorsProvider appColors) {
    return Consumer<TasbeehProvider>(
      builder: (context, tasbeehValue, child) {
        return Container(
          margin: EdgeInsets.only(top: 20.h,bottom: 20.h),
          width: 90.w,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(19.r),
            color: appColors.mainBrandingColor,
          ),
          child: Container(
            margin: EdgeInsets.only(top: 11.2.h,bottom: 11.2.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                    onTap: (){
                      tasbeehValue.setIsVibrate();
                    },
                    child: Icon(tasbeehValue.isVibrate ? Icons.volume_up : Icons.volume_off,color: Colors.white,size: 16.h,)),
                SizedBox(width: 22.45.w,),
                InkWell(
                    onTap: () async{
                      tasbeehValue.reset();
                    },
                    child: Icon(Icons.restore_rounded,color: Colors.white,size: 16.h,))
              ],
            ),
          ),
        );
      },
    );
  }

   _buildOtherTasbeehContainer(ThemProvider them, AppColorsProvider appColors, BuildContext context) {
    return Consumer<TasbeehProvider>(
      builder: (context, tasbeehValue, child) {
        return InkWell(
          onTap: () async{
            tasbeehValue.setIsCustomTasbeeh();
          },
          child: Container(
            width: double.infinity,
            margin: EdgeInsets.only(top: 8.h,bottom: 27.h,left: 20.w,right: 20.w),
            padding: EdgeInsets.only(top: 12.h,bottom: 12.h),
            decoration: BoxDecoration(
                color: them.isDark ? tasbeehValue.isCustomTasbeeh ? appColors.mainBrandingColor : AppColors.darkColor : tasbeehValue.isCustomTasbeeh ? appColors.mainBrandingColor : Colors.white,
                borderRadius: BorderRadius.circular(8.r),
                boxShadow: const [
                  BoxShadow(
                      offset: Offset(0, 4),
                      blurRadius: 12,
                      color: Color.fromRGBO(0, 0, 0, 0.08))
                ]),
            child: Text(localeText(context, "other_tasbeeh_of_your_choice"),textAlign: TextAlign.center,style: TextStyle(color: tasbeehValue.isCustomTasbeeh ? Colors.white : them.isDark ? Colors.white : Colors.black),),
          ),
        );
      },
    );
  }


}



