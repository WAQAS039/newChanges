import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:just_audio/just_audio.dart';
import 'package:nour_al_quran/shared/localization/localization_constants.dart';
import 'package:nour_al_quran/pages/quran/pages/recitation/reciter/player/player_provider.dart';
import 'package:nour_al_quran/pages/settings/pages/app_colors/app_colors_provider.dart';
import 'package:nour_al_quran/pages/settings/pages/app_them/them_provider.dart';
import 'package:nour_al_quran/shared/entities/surah.dart';
import 'package:nour_al_quran/shared/utills/app_colors.dart';
import 'package:nour_al_quran/shared/widgets/circle_button.dart';
import 'package:nour_al_quran/shared/widgets/title_text.dart';
import 'package:provider/provider.dart';

import '../../../../../../shared/widgets/app_bar.dart';

class AudioPlayerPage extends StatelessWidget {
  const AudioPlayerPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ValueNotifier<bool> isLoopMoreNotifier = ValueNotifier<bool>(false);
    bool isLoopMore = false;
    return Scaffold(
      appBar: buildAppBar(
          context: context,
          font: 16.sp,
          title: localeText(context, "playing_recitation")),
      body:
          Consumer3<ThemProvider, RecitationPlayerProvider, AppColorsProvider>(
        builder: (context, them, player, appColor, child) {
          return Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                        margin: EdgeInsets.only(
                          left: 20.w,
                          right: 20.w,
                        ),
                        child: Image.asset(
                          'assets/images/al_quran.png',
                        )),
                    Text(
                      player.reciter!.reciterName!,
                      style: TextStyle(
                          fontSize: 16.sp,
                          color:
                              them.isDark ? AppColors.grey4 : AppColors.grey3,
                          fontFamily: 'satoshi'),
                    ),
                    player.surah != null
                        ? Column(
                            children: [
                              Text(
                                "Surah ${player.surah!.surahName}",
                                style: TextStyle(
                                    fontSize: 22.sp,
                                    fontFamily: 'satoshi',
                                    fontWeight: FontWeight.w900),
                              ),
                              SizedBox(
                                height: 7.h,
                              ),
                              Text(
                                '${localeText(context, "surah")} # ${player.surah!.surahId}',
                                style: TextStyle(
                                    fontSize: 14.sp,
                                    fontFamily: 'satoshi',
                                    color: them.isDark
                                        ? AppColors.grey4
                                        : AppColors.grey3,
                                    fontWeight: FontWeight.w700),
                              ),
                            ],
                          )
                        : const SizedBox.shrink(),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(
                    left: 20.w, right: 20.w, bottom: 30.h, top: 20.h),
                width: double.maxFinite,
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text(
                            "${player.duration.inHours}:${player.duration.inMinutes.remainder(60)}:${player.duration.inSeconds.remainder(60)}"),
                        SliderTheme(
                          data: SliderThemeData(
                              overlayShape: SliderComponentShape.noOverlay,
                              trackHeight: 9.h,
                              thumbShape: const RoundSliderThumbShape(
                                elevation: 0.0,
                                enabledThumbRadius: 6,
                              )),
                          child: Expanded(
                            child: Container(
                              margin: EdgeInsets.only(left: 7.w, right: 7.w),
                              child: Slider(
                                min: 0.0,
                                thumbColor: appColor.mainBrandingColor,
                                activeColor: appColor.mainBrandingColor,
                                inactiveColor: AppColors.lightBrandingColor,
                                max: player.duration.inSeconds.toDouble(),
                                value: player.position.inSeconds.toDouble(),
                                onChanged: (value) {
                                  final position =
                                      Duration(seconds: value.toInt());
                                  player.audioPlayer.seek(position);
                                },
                              ),
                            ),
                          ),
                        ),
                        Text(
                            '- ${player.position.inMinutes.remainder(60)}:${player.position.inSeconds.remainder(60)}'),
                      ],
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        IconButton(
                          onPressed: () {
                            if (!isLoopMoreNotifier.value) {
                              isLoopMoreNotifier.value = true;
                              player.audioPlayer.setLoopMode(LoopMode.one);
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                  content: Text(
                                      'Loop More On For ${player.surah!.surahName!}')));
                            } else {
                              isLoopMoreNotifier.value = false;
                              player.audioPlayer.setLoopMode(LoopMode.off);
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                  content: Text(
                                      'Loop More Off For ${player.surah!.surahName!}')));
                            }
                          },
                          icon: ValueListenableBuilder<bool>(
                            valueListenable: isLoopMoreNotifier,
                            builder: (context, isLoopMore, child) {
                              return Image.asset(
                                'assets/images/app_icons/repeat.png',
                                height: 30.h,
                                width: 30.w,
                                color: isLoopMore
                                    ? appColor.mainBrandingColor
                                    : Theme.of(context).brightness ==
                                            Brightness.dark
                                        ? Colors.white
                                        : Colors.black,
                              );
                            },
                          ),
                          padding: EdgeInsets.zero,
                          alignment: Alignment.center,
                        ),
                        IconButton(
                          onPressed: () async {
                            player.seekToPrevious();
                          },
                          icon: Image.asset(
                            'assets/images/app_icons/previous.png',
                            height: 30.h,
                            width: 30.w,
                            color: them.isDark ? Colors.white : Colors.black,
                          ),
                          padding: EdgeInsets.zero,
                          alignment: Alignment.center,
                        ),
                        InkWell(
                          onTap: () async {
                            if (!player.isPlaying) {
                              await player.play(context);
                            } else {
                              await player.pause(context);
                            }
                          },
                          child: CircleButton(
                            height: 63.h,
                            width: 63.h,
                            icon: Icon(
                              player.isPlaying
                                  ? Icons.pause_rounded
                                  : Icons.play_arrow_rounded,
                              size: 40.h,
                              color: Colors.white,
                            ),
                            // Image.asset(
                            //   player.isPlaying ? "assets/images/app_icons/pause.png" : "assets/images/app_icons/play_mini.png",
                            //   height: 30.h,
                            //   width: 30.w,
                            // )
                          ),
                        ),
                        // InkWell(
                        //   onTap: () async{
                        //     if(!player.isPlaying){
                        //       await player.play();
                        //     }else{
                        //       await player.pause();
                        //     }
                        //   },
                        //   child: Image.asset('assets/images/app_icons/${player.isPlaying ? "pause_mainplayer" : "play_mainplayer"}.png',height: 63.h,width: 63.w,),
                        // ),
                        IconButton(
                          onPressed: () {
                            player.seekToNext();
                          },
                          icon: Image.asset(
                            'assets/images/app_icons/next.png',
                            height: 30.h,
                            width: 30.w,
                            color: them.isDark ? Colors.white : Colors.black,
                          ),
                          padding: EdgeInsets.zero,
                          alignment: Alignment.center,
                        ),
                        IconButton(
                          onPressed: () {
                            buildPlayListBottomSheet(context);
                          },
                          icon: Image.asset(
                            'assets/images/app_icons/list.png',
                            height: 30.h,
                            width: 30.w,
                            color: them.isDark ? Colors.white : Colors.black,
                          ),
                          padding: EdgeInsets.zero,
                          alignment: Alignment.center,
                        )
                      ],
                    )
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  buildPlayListBottomSheet(BuildContext context) async {
    var them = context.read<ThemProvider>().isDark;
    await showModalBottomSheet(
      isScrollControlled: true,
      useSafeArea: true,
      isDismissible: false,
      context: context,
      builder: (context) {
        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            elevation: 0.0,
            leading: IconButton(
              padding: EdgeInsets.zero,
              icon: Image.asset(
                'assets/images/app_icons/dropdown.png',
                height: 20.h,
                color: them ? Colors.white : Colors.black,
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            backgroundColor: Colors.transparent,
            title: TitleText(
              title: localeText(context, "surah_playlist"),
              fontSize: 16.sp,
            ),
          ),
          body: Consumer2<RecitationPlayerProvider, AppColorsProvider>(
            builder: (context, player, appColors, child) {
              return ListView.builder(
                itemCount: player.surahNamesList.length,
                itemBuilder: (context, index) {
                  Surah surah = player.surahNamesList[index];
                  return Container(
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
                        )),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: () {},
                          child: Container(
                            margin: EdgeInsets.only(left: 10.w, right: 10.w),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // color: AppColors.grey2
                                Row(
                                  children: [
                                    Text(
                                      "Surah ${surah.surahName}   ",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 12.sp,
                                        fontFamily: "satoshi",
                                      ),
                                    ),
                                    Text(
                                      player.surah!.surahId == surah.surahId
                                          ? player.isPlaying
                                              ? "(${localeText(context, "currently_playing")})"
                                              : "(${localeText(context, "currently_selected")})"
                                          : "",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w700,
                                          fontSize: 12.sp,
                                          fontFamily: "satoshi",
                                          color: appColors.mainBrandingColor),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 2.h,
                                ),
                                SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width * 0.6,
                                    child: Text(
                                      surah.englishName!,
                                      style: TextStyle(
                                          fontSize: 10.sp,
                                          fontFamily: "satoshi",
                                          color: AppColors.grey4),
                                    ))
                              ],
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () async {
                            player.setCurrentIndex(index);
                            player.audioPlayer
                                .seek(Duration.zero, index: index);
                            player.play(context);
                            Navigator.of(context).pop();
                          },
                          child: Container(
                            margin: EdgeInsets.only(
                                right: 10.h,
                                top: 17.h,
                                bottom: 16.h,
                                left: 10.w),
                            child: CircleButton(
                                height: 21.h,
                                width: 21.h,
                                icon: ImageIcon(
                                  AssetImage(player.surah!.surahId ==
                                          surah.surahId
                                      ? player.isPlaying
                                          ? "assets/images/app_icons/pause.png"
                                          : "assets/images/app_icons/play_mini.png"
                                      : "assets/images/app_icons/play_mini.png"),
                                  size: 9.h,
                                  color: Colors.white,
                                )),
                          ),
                        )
                      ],
                    ),
                  );
                },
              );
            },
          ),
        );
      },
    );
  }
}
