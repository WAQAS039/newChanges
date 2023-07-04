import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nour_al_quran/shared/widgets/title_row.dart';
import 'package:nour_al_quran/pages/quran/widgets/subtitle_text.dart';
import 'package:nour_al_quran/pages/settings/pages/translation_manager/translation_manager_provider.dart';
import 'package:nour_al_quran/pages/settings/pages/translation_manager/translations.dart';
import 'package:nour_al_quran/shared/localization/localization_constants.dart';
import 'package:nour_al_quran/shared/utills/app_colors.dart';
import 'package:nour_al_quran/shared/widgets/brand_button.dart';
import 'package:nour_al_quran/shared/widgets/circle_button.dart';
import 'package:provider/provider.dart';

import '../../../../shared/widgets/app_bar.dart';

class TranslationManagerPage extends StatelessWidget {
  const TranslationManagerPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration.zero,()=>context.read<TranslationManagerProvider>().init());
    var style = TextStyle(
        fontFamily: 'satoshi',
        fontSize: 14.sp,
        fontWeight: FontWeight.w500
    );
    return Scaffold(
      appBar: buildAppBar(context: context,title: localeText(context, "translation_manager")),
      body: Container(
        margin: EdgeInsets.only(left: 20.w,right: 20.w),
        child: Consumer<TranslationManagerProvider>(
          builder: (context, transProvider, child) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.only(top: 30.h,bottom: 14.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                          width: MediaQuery.of(context).size.width*0.4,
                          child: Text(localeText(context, "default_translation_language"),style: style,)),
                      DropdownButton<int>(
                        value: transProvider.defaultTranslations.indexWhere((element) => element.title == transProvider.defaultSelectedTranslation.title),
                        onChanged: (int? index) {
                          transProvider.selectTranslation(transProvider.defaultTranslations[index!]);
                        },
                        underline: const SizedBox.shrink(),
                        alignment: Alignment.topRight,
                        isDense: true,
                        items: transProvider.defaultTranslations
                            .map<DropdownMenuItem<int>>(
                              (e) => DropdownMenuItem<int>(
                            value: transProvider.defaultTranslations.indexOf(e),
                            child: Text(e.title!,style: TextStyle(
                              fontSize: 14.sp,
                              fontFamily: "satoshi",
                              fontWeight: FontWeight.w500,
                            ),),
                          ),
                        )
                            .toList(),
                      ),
                    ],
                  ),
                ),
                Text("Translations",style: style,),
                SizedBox(height: 10.h,),
                Expanded(
                  child: ListView.builder(
                    itemCount: transProvider.translations.length,
                    itemBuilder: (context, index) {
                      return Container(
                        margin: EdgeInsets.only(bottom: 8.h),
                        decoration: BoxDecoration(
                          border: Border.all(color: AppColors.grey5,),
                          borderRadius: BorderRadius.circular(6.r),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Container(
                                  margin: EdgeInsets.only(top: 11.h,left: 10.w,bottom: 10.h,right: 9.w),
                                  height: 33.h,
                                  width: 33.w,
                                  decoration: BoxDecoration(
                                      image: DecorationImage(image: AssetImage(transProvider.translations[index].image!)),
                                      borderRadius: BorderRadius.circular(6.r)
                                  ),),
                                // color: AppColors.grey2
                                Text(transProvider.translations[index].title!,style: TextStyle(fontSize: 12.sp,fontWeight: FontWeight.w700))
                              ],
                            ),
                            InkWell(
                              onTap:(){
                                transProvider.downloadTranslation(index,context);
                              },
                              child: Container(
                                  margin: EdgeInsets.only(right: 10.w,top: 17.h,bottom: 16.h,left: 10.w),
                                  child: CircleButton(height: 21.h, width: 21.w, icon:ImageIcon(const AssetImage('assets/images/app_icons/download_cloud.png'),size: 11.h,color: Colors.white,))),
                            ),
                          ],
                        ),
                      );
                    },),
                ),
                BrandButton(text: localeText(context, "save_settings"), onTap: (){
                  transProvider.saveSelectedTranslation(context);
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Language Selected')));
                  Navigator.of(context).pop();
                }),
                SizedBox(height: 20.h,),
              ],
            );
          },
        ),
      ),
    );
  }
}
