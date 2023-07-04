import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nour_al_quran/pages/quran/pages/recitation/recitation_provider.dart';
import 'package:nour_al_quran/pages/quran/pages/recitation/reciter/reciter_provider.dart';
import 'package:nour_al_quran/pages/quran/widgets/subtitle_text.dart';
import 'package:nour_al_quran/shared/entities/reciters.dart';
import 'package:nour_al_quran/shared/localization/localization_constants.dart';
import 'package:nour_al_quran/shared/routes/routes_helper.dart';
import 'package:nour_al_quran/shared/utills/app_colors.dart';
import 'package:nour_al_quran/shared/widgets/circle_button.dart';
import 'package:provider/provider.dart';
import 'package:cached_network_image/cached_network_image.dart';

class FavoritesRecitersPage extends StatelessWidget {
  const FavoritesRecitersPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<RecitationProvider>().getFavReciter();
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      SubTitleText(title: localeText(context, "favorite_reciters")),
      Consumer<RecitationProvider>(
        builder: (context, recitation, child) {
          return recitation.favReciters.isNotEmpty ? Expanded(
            child: MediaQuery.removePadding(
              context: context,
              removeTop: true,
              child: ListView.builder(
                itemCount: recitation.favReciters.length,
                  itemBuilder: (context, index) {
                  Reciters reciter = recitation.favReciters[index];
                    return InkWell(
                      onTap: (){
                        recitation.getSurahName();
                        // context.read<ReciterProvider>().resetDownloadSurahList();
                        context.read<ReciterProvider>().setReciterList(reciter.downloadSurahList!);
                        Navigator.of(context).pushNamed(RouteHelper.reciter,arguments: reciter);
                      },
                      child: Container(
                        // height: 54.h,
                        margin: EdgeInsets.only(left: 20.w, right: 20.w,bottom: 10.h),
                        decoration: BoxDecoration(
                          // color: AppColors.grey6,
                          border: Border.all(color: AppColors.grey5,),
                          borderRadius: BorderRadius.circular(6.r),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Container(
                                  height: 37.h,width: 37.h,
                                  margin: EdgeInsets.only(top: 9.h, left: 10.w, bottom: 8.h, right: 8.w),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(30.r),
                                    child: CachedNetworkImage(
                                      fit: BoxFit.cover,
                                      imageUrl: reciter.imageUrl!,
                                      progressIndicatorBuilder: (context, url, downloadProgress) =>
                                          CircularProgressIndicator(value: downloadProgress.progress,strokeWidth: 1,),
                                      errorWidget: (context, url, error) => const Icon(Icons.person),
                                    ),
                                  ),
                                ),
                                Text(
                                  // color: AppColors.grey2
                                  reciter.reciterName!,
                                  style: TextStyle(fontSize: 12.sp,fontWeight: FontWeight.w700),
                                )
                              ],
                            ),
                            InkWell(
                              onTap:(){
                                recitation.removeFavReciter(reciter.reciterId!);
                              },
                              child: Container(
                                margin: EdgeInsets.only(right: 10.w, top: 17.h, bottom: 16.h,left: 10.w),
                                child: CircleButton(height: 21.h, width: 21.w, icon: Icon(Icons.favorite,size: 11.h,color: Colors.white,),),),
                            )
                          ],
                        ),
                      ),
                    );
                  },),
            ),
          ) : const Expanded(child: Center(child: Text('No Fav Reciters Yet'),
          ));
        },
      )
    ]);
  }
}
