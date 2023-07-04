import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nour_al_quran/pages/quran/pages/recitation/reciter/reciter_provider.dart';
import 'package:nour_al_quran/pages/quran/pages/recitation/recitation_provider.dart';
import 'package:nour_al_quran/pages/settings/pages/app_colors/app_colors_provider.dart';
import 'package:nour_al_quran/shared/entities/reciters.dart';
import 'package:nour_al_quran/pages/quran/widgets/subtitle_text.dart';
import 'package:nour_al_quran/shared/localization/localization_constants.dart';
import 'package:nour_al_quran/shared/routes/routes_helper.dart';
import 'package:nour_al_quran/shared/utills/app_colors.dart';
import 'package:provider/provider.dart';

import '../../widgets/details_container_widget.dart';

class RecitationPage extends StatelessWidget {
  const RecitationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<RecitationProvider>().getReciters();
    context.read<RecitationProvider>().getFavReciter();
    var appColor = context.read<AppColorsProvider>().mainBrandingColor;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SubTitleText(title: localeText(context, "reciters_page")),
                InkWell(
                  onTap: () {
                    Navigator.of(context).pushNamed(RouteHelper.allReciters);
                  },
                  child: Container(
                      margin: EdgeInsets.only(
                          bottom: 10.h, right: 20.w, left: 20.w),
                      child: Text(
                        localeText(context, "view_all"),
                        style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w900,
                            color: appColor),
                      )),
                ),
              ],
            ),
            Consumer<RecitationProvider>(
              builder: (context, recitersValue, child) {
                return recitersValue.recitersList.isNotEmpty
                    ? GridView.builder(
                        padding: EdgeInsets.only(left: 20.w, right: 20.w),
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: 4,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 4,
                            mainAxisExtent: 116.87.h,
                            mainAxisSpacing: 10.h,
                            crossAxisSpacing: 5.w),
                        itemBuilder: (BuildContext context, int index) {
                          Reciters reciter = recitersValue.recitersList[index];
                          return InkWell(
                            onTap: () async {
                              recitersValue.getSurahName();
                              // context.read<ReciterProvider>().resetDownloadSurahList();
                              context
                                  .read<ReciterProvider>()
                                  .setReciterList(reciter.downloadSurahList!);
                              // context.read<ReciterProvider>().getAvailableDownloadAudioFilesFromLocal(reciter.reciterName!);
                              Navigator.of(context).pushNamed(
                                  RouteHelper.reciter,
                                  arguments: reciter);
                            },
                            child: buildReciterDetailsContainer(reciter),
                          );
                        },
                      )
                    : const CircularProgressIndicator();
              },
            ),
            buildTitleContainer(localeText(context, "favorites")),
            Consumer<RecitationProvider>(
              builder: (context, recitation, child) {
                return recitation.favReciters.isNotEmpty
                    ? MediaQuery.removePadding(
                        context: context,
                        removeTop: true,
                        child: ListView.builder(
                          itemCount: recitation.favReciters.length,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            Reciters reciter = recitation.favReciters[index];
                            return InkWell(
                              onTap: () {
                                recitation.getSurahName();
                                // context.read<ReciterProvider>().resetDownloadSurahList();
                                context
                                    .read<ReciterProvider>()
                                    .setReciterList(reciter.downloadSurahList!);
                                Navigator.of(context).pushNamed(
                                    RouteHelper.reciter,
                                    arguments: reciter);
                              },
                              child: DetailsContainerWidget(
                                title: reciter.reciterName!,
                                subTitle: localeText(context, "reciters"),
                                icon: Icons.bookmark,
                                imageIcon: "assets/images/app_icons/heart.png",
                                onTapIcon: () {
                                  recitation
                                      .removeFavReciter(reciter.reciterId!);
                                },
                              ),
                            );
                          },
                        ),
                      )
                    : messageContainer(
                        localeText(context, "no_fav_reciter_added_yet"));
              },
            ),
          ],
        ),
      ),
    );
  }

  Container buildTitleContainer(String title) {
    return Container(
        margin:
            EdgeInsets.only(bottom: 10.h, left: 20.w, top: 2.h, right: 20.w),
        child: Text(
          title,
          style: TextStyle(fontSize: 17.sp, fontWeight: FontWeight.bold),
        ));
  }

  Container buildReciterDetailsContainer(Reciters reciter) {
    return Container(
      margin: EdgeInsets.only(right: 7.w),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          SizedBox(
            height: 71.18.h,
            width: 71.18.w,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(35.59.r),
              child: CachedNetworkImage(
                fit: BoxFit.cover,
                imageUrl: reciter.imageUrl!,
                placeholder: (context, url) => const CircularProgressIndicator(
                  color: AppColors.mainBrandingColor,
                ),
                errorWidget: (context, url, error) => const Icon(Icons.person),
              ),
            ),
          ),
          SizedBox(
            height: 3.h,
          ),
          Text(
            reciter.reciterName!,
            softWrap: true,
            maxLines: 3,
            style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 11.sp,
                height: 1.3.h,
                fontFamily: "satoshi"),
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }

  Container messageContainer(String msg) {
    return Container(
      height: 100.h,
      alignment: Alignment.center,
      child: Text(msg),
    );
  }
}
