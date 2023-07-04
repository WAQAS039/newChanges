import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nour_al_quran/pages/quran/pages/recitation/reciter/player/player_provider.dart';
//import 'package:nour_al_quran/pages/quran/widgets/subtitle_text.dart';
import 'package:nour_al_quran/pages/settings/pages/app_colors/app_colors_provider.dart';
import 'package:nour_al_quran/shared/localization/localization_constants.dart';
import 'package:nour_al_quran/shared/localization/localization_provider.dart';
import 'package:nour_al_quran/shared/routes/routes_helper.dart';
import 'package:provider/provider.dart';

import 'models/ruqyah_category.dart';
import 'models/ruqyah_provider.dart';

class RuqyahCategoriesPage extends StatelessWidget {
  const RuqyahCategoriesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var appColors = context.read<AppColorsProvider>().mainBrandingColor;
    context.read<RuqyahProvider>().getRDuaCategories();
    return Consumer<RuqyahProvider>(
      builder: (context, duaValue, child) {
        return duaValue.duaCategoryList.isNotEmpty
            ? GridView.builder(
                padding: EdgeInsets.only(
                  // top: 10.h,
                  left: 20.w,
                  right: 20.w,
                  // bottom: 10.h
                ),
                itemCount: duaValue.duaCategoryList.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  // crossAxisSpacing: 12.w,
                  // mainAxisSpacing: 10.h,
                ),
                itemBuilder: (context, index) {
                  RuqyahCategory duaCategory = duaValue.duaCategoryList[index];

                  return InkWell(
                    onTap: () async {
                      /// if recitation player is on So this line is used to pause the player
                      Future.delayed(
                        Duration.zero,
                        () => context
                            .read<RecitationPlayerProvider>()
                            .pause(context),
                      );
                      duaValue.getRDua(duaCategory.categoryId!);

                      // context.read<QuranDbProvider>().setDuaList(await QuranDatabase().getDua(duaCategory.categoryId!));
                      Navigator.of(context).pushNamed(
                        RouteHelper.ruqyah,
                        arguments: [
                          localeText(context, duaCategory.categoryName!),
                          duaCategory.imageUrl,
                          LocalizationProvider().checkIsArOrUr()
                              ? "${duaCategory.noOfDua!} ${localeText(context, 'duas')} ${localeText(context, 'collection_of')} "
                              : "${localeText(context, 'playlist_of')} ${duaCategory.noOfDua!} ${localeText(context, 'duas')}",
                          duaCategory.categoryId,
                        ],
                      );
                    },
                    child: Container(
                      height: 149.h,
                      margin: EdgeInsets.only(right: 9.w, bottom: 9.h),
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(8.r),
                        image: DecorationImage(
                            image: AssetImage(duaCategory.imageUrl!),
                            fit: BoxFit.cover),
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.r),
                          gradient: const LinearGradient(
                            colors: [
                              Color.fromRGBO(0, 0, 0, 0),
                              Color.fromRGBO(0, 0, 0, 1),
                            ],
                            begin: Alignment.center,
                            end: Alignment.bottomCenter,
                          ),
                        ),
                        child: Container(
                          width: double.maxFinite,
                          margin: EdgeInsets.only(
                            left: 6.w, bottom: 8.h,
                            // right: 6.w
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                localeText(context, duaCategory.categoryName!),
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14.sp,
                                    fontFamily: "satoshi",
                                    fontWeight: FontWeight.w700),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              )
            : Center(
                child: CircularProgressIndicator(
                  color: appColors,
                ),
              );
      },
    );
  }
}
