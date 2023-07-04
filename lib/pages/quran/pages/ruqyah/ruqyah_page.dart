import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nour_al_quran/pages/settings/pages/app_colors/app_colors_provider.dart';
import 'package:nour_al_quran/shared/utills/app_colors.dart';
import 'package:nour_al_quran/shared/widgets/title_text.dart';
import 'package:provider/provider.dart';
import '../../../../shared/routes/routes_helper.dart';
import 'models/ruqyah.dart';
import 'models/ruqyah_provider.dart';

class RuqyahPage extends StatelessWidget {
  const RuqyahPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List arguments = ModalRoute.of(context)!.settings.arguments! as List;
    String title = arguments[0];
    String imageUrl = arguments[1];
    String collectionOfDua = arguments[2];

    //Split Collection
    List<String> splitText = collectionOfDua.split(' ');
    String duaCount = splitText[0];
    String duasText = splitText.sublist(1).join(' ');

    return Scaffold(
      body: SafeArea(
        child: Consumer2<AppColorsProvider, RuqyahProvider>(
          builder: (context, appColors, duaProvider, child) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: const Icon(Icons.arrow_back_outlined),
                  padding: EdgeInsets.only(
                      left: 20.w, top: 13.41.h, bottom: 21.4.h, right: 20.w),
                  alignment: Alignment.topLeft,
                ),
                Container(
                  margin:
                      EdgeInsets.only(bottom: 18.h, left: 20.w, right: 20.w),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 110.h,
                        width: 120.w,
                        decoration: BoxDecoration(
                          color: Colors.amberAccent,
                          borderRadius: BorderRadius.circular(22),
                          image: DecorationImage(
                            image: AssetImage(imageUrl),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          margin: EdgeInsets.only(top: 19.4.h, bottom: 18.h),
                          padding: EdgeInsets.only(
                              left: 17.w, top: 13.41.h, right: 20.w),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TitleText(
                                title: title,
                                style: TextStyle(
                                  fontWeight: FontWeight.w800,
                                  fontSize: 17.sp,
                                  fontFamily: "satoshi",
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(left: 0.w, top: 8.h),
                                child: RichText(
                                  text: TextSpan(
                                    style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 14.sp,
                                      fontFamily: "satoshi",
                                      color: AppColors.darkColor,
                                    ),
                                    children: [
                                      TextSpan(text: duaCount),
                                      const TextSpan(text: ' '),
                                      TextSpan(
                                        text: duasText,
                                        style: TextStyle(
                                            color: appColors.mainBrandingColor),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: duaProvider.duaList.length,
                    itemBuilder: (context, index) {
                      Ruqyah dua = duaProvider.duaList[index];
                      duaProvider.duaList[index].translations.toString();
                      String duaCount = dua.ayahCount.toString();

                      return InkWell(
                        onTap: () {
                          Navigator.of(context).pushNamed(
                            RouteHelper.ruqyahDetailed,
                          );
                          duaProvider.gotoDuaPlayerPage(
                              dua.duaCategory!, dua.duaText!, context);
                        },
                        child: Container(
                          margin: EdgeInsets.only(
                            left: 20.w,
                            right: 20.w,
                            bottom: 8.h,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6.r),
                            border: Border.all(
                              color: AppColors.grey5,
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                margin: EdgeInsets.only(left: 10.w),
                                child: Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 5, bottom: 5),
                                      child: CircleAvatar(
                                        radius: 17,
                                        backgroundColor:
                                            appColors.mainBrandingColor,
                                        child: Container(
                                          width: 25,
                                          height: 25,
                                          alignment: Alignment.center,
                                          child: Text(
                                            "${index + 1}",
                                            textAlign: TextAlign.center,
                                            style: const TextStyle(
                                              fontSize: 11,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 10.h),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          capitalize(dua.duaTitle.toString()),
                                          style: TextStyle(
                                            fontWeight: FontWeight.w700,
                                            fontSize: 12.sp,
                                            fontFamily: "satoshi",
                                          ),
                                        ),
                                        SizedBox(height: 2.h),
                                        SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.6,
                                          child: Text(
                                            dua.duaRef.toString(),
                                            style: TextStyle(
                                              fontSize: 10.sp,
                                              fontFamily: "satoshi",
                                              color: AppColors.grey4,
                                            ),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(
                                  right: 10.h,
                                  top: 5.h,
                                  bottom: 5.h,
                                ),
                                child: CircleAvatar(
                                  radius: 16.h,
                                  backgroundColor: Colors.grey[300],
                                  child: Container(
                                    width: 21.h,
                                    height: 21.h,
                                    alignment: Alignment.center,
                                    child: Text(
                                      duaCount,
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                        fontSize: 11,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  String capitalize(String text) {
    if (text.isEmpty) {
      return text;
    }
    return text[0].toUpperCase() + text.substring(1);
  }
}
