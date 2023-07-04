import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nour_al_quran/pages/quran/pages/recitation/reciter/player/player_provider.dart';
import 'package:nour_al_quran/pages/settings/pages/app_colors/app_colors_provider.dart';
import 'package:nour_al_quran/shared/routes/routes_helper.dart';
import 'package:nour_al_quran/shared/widgets/custom_track_shape.dart';
import 'package:provider/provider.dart';

import '../../../../../../shared/utills/app_colors.dart';
import '../../../../../../shared/widgets/circle_button.dart';
import '../../../../../settings/pages/app_them/them_provider.dart';
import 'audio_player_page.dart';

class MiniPlayer extends StatelessWidget {
  const MiniPlayer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer3<AppColorsProvider, ThemProvider, RecitationPlayerProvider>(
      builder: (context, appColors, them, player, child) {
        return player.isOpen
            ? InkWell(
                onTap: () {
                  Navigator.of(context).pushNamed(RouteHelper.audioPlayer);
                },
                child: Container(
                  width: double.maxFinite,
                  // height: 62.h,
                  color: !them.isDark
                      ? AppColors.lightBrandingColor
                      : AppColors.grey1,
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Container(
                                  margin: EdgeInsets.only(
                                    top: 8.h,
                                    left: 20.w,
                                    right: 7.w,
                                  ),
                                  child: CircleAvatar(
                                    backgroundImage: CachedNetworkImageProvider(
                                      player.reciter!.imageUrl!,
                                    ),
                                  ),
                                ),
                                Container(
                                  margin:
                                      EdgeInsets.only(top: 12.h, bottom: 9.h),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        player.reciter!.reciterName!,
                                        style: TextStyle(
                                            color: Theme.of(context)
                                                .textTheme
                                                .headlineLarge!
                                                .color,
                                            fontSize: 14.sp,
                                            fontFamily: "satoshi",
                                            fontWeight: FontWeight.w700),
                                      ),
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.58,
                                        child: Text(
                                          '${player.surah!.englishName!}, Surah ${player.surah!.surahName}',
                                          style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 10.sp,
                                              fontFamily: "satoshi",
                                              color: !them.isDark
                                                  ? AppColors.grey2
                                                  : AppColors.grey4),
                                        ),
                                      ),
                                      // i want to give all available width to this
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              margin: EdgeInsets.only(
                                  bottom: 2.h, left: 68.w, right: 68.w),
                              child: SliderTheme(
                                data: SliderThemeData(
                                    overlayShape:
                                        SliderComponentShape.noOverlay,
                                    trackHeight: 5.h,
                                    trackShape: CustomTrackShape(),
                                    thumbShape: const RoundSliderThumbShape(
                                      elevation: 0.0,
                                      enabledThumbRadius: 3.5,
                                    )),
                                child: Slider(
                                  min: 0.0,
                                  thumbColor: appColors.mainBrandingColor,
                                  activeColor: appColors.mainBrandingColor,
                                  inactiveColor: Colors.white,
                                  max: player.duration.inSeconds.toDouble(),
                                  value: player.position.inSeconds.toDouble(),
                                  onChanged: (value) {
                                    final position =
                                        Duration(seconds: value.toInt());
                                    // _audioPlayer!.seek(position);
                                    player.audioPlayer.seek(position);
                                  },
                                ),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(
                                  left: 69.w, bottom: 7.h, right: 69.w),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                      "${player.duration.inHours}:${player.duration.inMinutes.remainder(60)}:${player.duration.inSeconds.remainder(60)}",
                                      style: TextStyle(
                                          fontSize: 6.sp,
                                          color: AppColors.grey2,
                                          fontFamily: 'satoshi')),
                                  Text(
                                    '- ${player.position.inMinutes.remainder(60)}:${player.position.inSeconds.remainder(60)}',
                                    style: TextStyle(
                                        fontSize: 6.sp,
                                        color: AppColors.grey2,
                                        fontFamily: 'satoshi'),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(
                            right: 19.22.w,
                            top: 15.h,
                            left: 11.w,
                            bottom: 34.h),
                        child: Row(
                          children: [
                            InkWell(
                              onTap: () async {
                                if (player.isPlaying) {
                                  await player.pause(context);
                                } else {
                                  await player.play(context);
                                }
                              },
                              child: CircleButton(
                                  height: 27.h,
                                  width: 27.w,
                                  icon: Icon(
                                    player.isPlaying
                                        ? Icons.pause
                                        : Icons.play_arrow,
                                    size: 13.h,
                                    color: Colors.white,
                                  )),
                            ),
                            SizedBox(
                              width: 11.w,
                            ),
                            InkWell(
                              onTap: () {
                                player.closePlayer();
                              },
                              child: ImageIcon(
                                const AssetImage(
                                  "assets/images/app_icons/close.png",
                                ),
                                size: 9.58.h,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              )
            : const SizedBox.shrink();
      },
    );
  }
}
