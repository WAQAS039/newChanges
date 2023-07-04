import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nour_al_quran/pages/quran/pages/recitation/reciter/player/audio_player_page.dart';
import 'package:nour_al_quran/pages/quran/pages/recitation/reciter/player/mini_player.dart';
import 'package:nour_al_quran/pages/quran/pages/recitation/reciter/player/player_provider.dart';
import 'package:nour_al_quran/pages/quran/pages/recitation/reciter/reciter_provider.dart';
import 'package:nour_al_quran/pages/quran/pages/recitation/recitation_provider.dart';
import 'package:nour_al_quran/pages/settings/pages/app_colors/app_colors_provider.dart';
import 'package:nour_al_quran/shared/entities/reciters.dart';
import 'package:nour_al_quran/shared/entities/surah.dart';
import 'package:nour_al_quran/shared/localization/localization_constants.dart';
import 'package:nour_al_quran/shared/localization/localization_provider.dart';
import 'package:nour_al_quran/shared/network/network_check.dart';
import 'package:nour_al_quran/shared/providers/download_provider.dart';
import 'package:nour_al_quran/shared/routes/routes_helper.dart';
import 'package:nour_al_quran/shared/utills/app_colors.dart';
import 'package:nour_al_quran/shared/widgets/circle_button.dart';
import 'package:provider/provider.dart';

class ReciterPage extends StatelessWidget {
  const ReciterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Reciters? reciters = ModalRoute.of(context)!.settings.arguments as Reciters;
    return WillPopScope(
      onWillPop: () async {
        context.read<RecitationProvider>().getFavReciter();
        return true;
      },
      child: Scaffold(
        body: SafeArea(
          child:
              Consumer3<AppColorsProvider, ReciterProvider, RecitationProvider>(
            builder: (context, appColors, reciterProvider, recitationProvider,
                child) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  IconButton(
                    onPressed: () {
                      // to get fresh data for fav reciter list
                      context.read<RecitationProvider>().getFavReciter();
                      Navigator.of(context).pop();
                    },
                    icon: const Icon(Icons.arrow_back_outlined),
                    padding:
                        EdgeInsets.only(left: 20.w, top: 13.41.h, right: 20.w),
                    alignment: Alignment.topLeft,
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 20.w, right: 20.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Container(
                              margin: EdgeInsets.only(
                                  top: 19.4.h,
                                  bottom: 16.h,
                                  right: LocalizationProvider()
                                                  .locale
                                                  .languageCode ==
                                              "ur" ||
                                          LocalizationProvider()
                                                  .locale
                                                  .languageCode ==
                                              "ar"
                                      ? 0
                                      : 8.w,
                                  left: LocalizationProvider()
                                                  .locale
                                                  .languageCode ==
                                              "ur" ||
                                          LocalizationProvider()
                                                  .locale
                                                  .languageCode ==
                                              "ar"
                                      ? 8.w
                                      : 0),
                              child: CircleAvatar(
                                backgroundImage: CachedNetworkImageProvider(
                                  reciters.imageUrl!,
                                ),
                              ),
                            ),
                            Container(
                              margin:
                                  EdgeInsets.only(top: 21.4.h, bottom: 18.h),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    reciters.reciterName!,
                                    style: TextStyle(
                                        // color: Colors.black,
                                        fontSize: 15.sp,
                                        fontFamily: "satoshi",
                                        fontWeight: FontWeight.w700),
                                  ),
                                  Text(
                                    localeText(context, "complete_quran"),
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 14.sp,
                                        fontFamily: "satoshi",
                                        color: AppColors.grey4),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            reciterProvider.downloadSurahList.length == 113
                                ? InkWell(
                                    onTap: () {
                                      // audio play logic
                                      context
                                          .read<RecitationPlayerProvider>()
                                          .initAudioPlayer(reciters, 0);
                                      Navigator.of(context)
                                          .pushNamed(RouteHelper.audioPlayer);
                                    },
                                    child: Container(
                                      height: 23.h,
                                      width: 23.w,
                                      margin: EdgeInsets.only(
                                          top: 29.4.h, bottom: 25.h),
                                      child: CircleAvatar(
                                        backgroundColor:
                                            appColors.mainBrandingColor,
                                        child: Icon(
                                          Icons.play_arrow,
                                          color: Colors.white,
                                          size: 13.h,
                                        ),
                                      ),
                                    ),
                                  )
                                : const SizedBox.shrink(),
                            InkWell(
                              onTap: () {
                                if (reciters.isFav == 0) {
                                  recitationProvider
                                      .addFav(reciters.reciterId!);
                                } else {
                                  recitationProvider
                                      .removeFavReciter(reciters.reciterId!);
                                }
                              },
                              child: Container(
                                height: 23.h,
                                width: 23.w,
                                margin: EdgeInsets.only(
                                  top: 29.4.h,
                                  bottom: 25.h,
                                ),
                                child: CircleAvatar(
                                  backgroundColor: appColors.mainBrandingColor,
                                  child: SizedBox(
                                    height: 21.h,
                                    width: 21.w,
                                    child: CircleAvatar(
                                      backgroundColor: reciters.isFav == 1
                                          ? appColors.mainBrandingColor
                                          : Colors.white,
                                      child: Icon(
                                        Icons.favorite,
                                        color: reciters.isFav == 1
                                            ? Colors.white
                                            : appColors.mainBrandingColor,
                                        size: 13.h,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: recitationProvider.surahNamesList.length,
                      itemBuilder: (context, index) {
                        Surah surah = recitationProvider.surahNamesList[index];
                        int downloadItem = 0;
                        if (reciterProvider.downloadSurahList
                            .contains(surah.surahId)) {
                          downloadItem = surah.surahId!;
                        }
                        return InkWell(
                          onTap: !reciterProvider.isDownload
                              ? () {
                                  downloadOrPlayAudio(reciterProvider, surah,
                                      context, reciters);
                                }
                              : null,
                          child: Container(
                            margin: EdgeInsets.only(
                              left: 20.w,
                              right: 20.w,
                              bottom: 8.h,
                            ),
                            decoration: BoxDecoration(
                              // color: AppColors.grey6,
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
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      // color: AppColors.grey2
                                      Text(
                                        "Surah ${surah.surahName}",
                                        style: TextStyle(
                                          fontWeight: FontWeight.w700,
                                          fontSize: 16.sp,
                                          fontFamily: "satoshi",
                                        ),
                                      ),
                                      SizedBox(
                                        height: 2.h,
                                      ),
                                      SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.6,
                                          child: Text(
                                            surah.englishName!,
                                            style: TextStyle(
                                                fontSize: 14.sp,
                                                fontFamily: "satoshi",
                                                color: AppColors.grey4),
                                          ))
                                    ],
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(
                                      right: 10.h,
                                      top: 17.h,
                                      bottom: 16.h,
                                      left: 10.w),
                                  child: CircleButton(
                                      height: 21.h,
                                      width: 21.h,
                                      icon: ImageIcon(
                                        AssetImage(downloadItem == surah.surahId
                                            ? "assets/images/app_icons/view.png"
                                            : "assets/images/app_icons/download_cloud.png"),
                                        size: 9.h,
                                        color: Colors.white,
                                      )),
                                )
                              ],
                            ),
                          ),
                        );
                        //   DetailsContainerWidget(
                        //   title: "Surah ${surah.surahName}",
                        //   subTitle: surah.englishName!,
                        //   icon: Icons.remove_red_eye_outlined,
                        //   imageIcon: downloadItem == surah.surahId ? "assets/icons/play.png" : "assets/icons/download_cloud.png",
                        //   onTapIcon: () async {
                        //     if(!downloads.downloadSurahList.contains(surah.surahId)){
                        //       downloads.updateDownloadSurahList(surah.surahId!);
                        //       reciters.setDownloadSurahList = downloads.downloadSurahList;
                        //       await QuranDatabase().updateReciterDownloadList(reciters.reciterId!, reciters);
                        //     }else{
                        //       print("do Play Logic");
                        //     }
                        //   },
                        // );
                      },
                    ),
                  ),
                ],
              );
            },
          ),
        ),
        bottomNavigationBar: Column(
          mainAxisSize: MainAxisSize.min,
          children: const [
            MiniPlayer(),
          ],
        ),
      ),
    );
  }

  void downloadOrPlayAudio(ReciterProvider reciterProvider, Surah surah,
      BuildContext context, Reciters reciters) {
    if (!reciterProvider.downloadSurahList.contains(surah.surahId)) {
      reciterProvider.setIsDownloading(true);
      NetworksCheck(onComplete: () async {
        reciterProvider.downloadSurah(surah, context, reciters);
        await buildDownloadingDialog(context, surah);
        reciterProvider.setIsDownloading(false);
      }, onError: () {
        reciterProvider.setIsDownloading(false);
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text('No Internet')));
      }).doRequest();
    } else {
      // audio play logic
      context.read<RecitationPlayerProvider>().initAudioPlayer(
          reciters,
          reciters.downloadSurahList!
              .indexWhere((element) => element == surah.surahId));
      Navigator.of(context).pushNamed(RouteHelper.audioPlayer);
    }
  }

  Future<dynamic> buildDownloadingDialog(BuildContext context, Surah surah) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return WillPopScope(
          onWillPop: () async {
            return false;
          },
          child: Consumer2<DownloadProvider, AppColorsProvider>(
            builder: (context, value, appColors, child) {
              return AlertDialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.r)),
                insetPadding: EdgeInsets.only(left: 20.w, right: 20.w),
                contentPadding: EdgeInsets.only(left: 27.w, right: 27.w),
                clipBehavior: Clip.antiAliasWithSaveLayer,
                content: SizedBox(
                  // height: 226.h,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 30.h, bottom: 15.h),
                        height: 89.h,
                        width: 89.w,
                        child: CircleAvatar(
                          backgroundColor: appColors.mainBrandingColor,
                          child: ImageIcon(
                            const AssetImage(
                              'assets/images/app_icons/download_cloud.png',
                            ),
                            size: 42.76.h,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(bottom: 14.h),
                        child: Text(
                          '${surah.surahName} ${localeText(context, "audio_is_downloading")}',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 16.sp,
                              fontFamily: "satoshi",
                              fontWeight: FontWeight.w700),
                        ),
                      ),
                      SizedBox(
                        height: 6.h,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(2.5.r),
                          child: LinearProgressIndicator(
                            value: value.downloadProgress,
                            backgroundColor: AppColors.lightBrandingColor,
                            valueColor: AlwaysStoppedAnimation<Color>(
                                appColors.mainBrandingColor),
                          ),
                        ),
                      ),
                      Container(
                          margin: EdgeInsets.only(top: 13.h, bottom: 23.h),
                          child: Text(value.downloadText,
                              style: TextStyle(
                                  fontSize: 10.sp,
                                  color: AppColors.grey3,
                                  fontFamily: "satoshi",
                                  fontWeight: FontWeight.w700)))
                    ],
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
