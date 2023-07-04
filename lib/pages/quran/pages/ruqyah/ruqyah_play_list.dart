import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../../../shared/utills/app_colors.dart';
import '../../../../shared/localization/localization_constants.dart';
import '../../../../shared/widgets/app_bar.dart';
import '../../../settings/pages/app_colors/app_colors_provider.dart';
import 'models/ruqyah.dart';
import 'models/ruqyah_provider.dart';

class RuqyahPlayList extends StatelessWidget {
  const RuqyahPlayList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(
          context: context,
          font: 16.sp,
          title: localeText(context, "playlist_dua")),
      body: SafeArea(
        child: Consumer2<AppColorsProvider, RuqyahProvider>(
          builder: (context, appColors, duaProvider, child) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: duaProvider.duaList.length,
                    itemBuilder: (context, duacategoryID) {
                      Ruqyah dua = duaProvider.duaList[duacategoryID];
                      String duaCount = dua.ayahCount.toString();

                      return InkWell(
                        onTap: () {
                          //       duaProvider.gotoDuaPlayerPage(dua.id!, context);
                          Navigator.pop(context);
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
                                  margin:
                                      EdgeInsets.only(left: 10.w, right: 10.w),
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
                                              "${duacategoryID + 1}",
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
                                          SizedBox(height: 5.h),
                                          SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.6,
                                            child: Text(
                                              dua.duaRef.toString(),
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                fontSize: 10.sp,
                                                fontFamily: "satoshi",
                                                color: AppColors.grey4,
                                              ),
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
                                    // left: 10.w,
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
                              ]),
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
