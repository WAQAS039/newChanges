import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:just_audio/just_audio.dart';
import 'package:nour_al_quran/pages/more/pages/names_of_allah/names.dart';
import 'package:nour_al_quran/pages/more/pages/names_of_allah/names_provider.dart';
import 'package:nour_al_quran/pages/settings/pages/app_colors/app_colors_provider.dart';
import 'package:nour_al_quran/shared/localization/localization_provider.dart';
import 'package:nour_al_quran/pages/settings/pages/app_them/them_provider.dart';
import 'package:nour_al_quran/shared/utills/app_colors.dart';
import 'package:nour_al_quran/shared/utills/dimensions.dart';
import 'package:nour_al_quran/shared/widgets/circle_button.dart';
import 'package:provider/provider.dart';

import '../../../../shared/widgets/app_bar.dart';

class NamesOfALLAHPage extends StatefulWidget {
  const NamesOfALLAHPage({Key? key}) : super(key: key);

  @override
  State<NamesOfALLAHPage> createState() => _NamesOfALLAHPageState();
}

class _NamesOfALLAHPageState extends State<NamesOfALLAHPage> {
  final AudioPlayer audioPlayer = AudioPlayer();
  int currentAudioIndex = 0;
  bool isAudioPlaying = false;
  bool isAudioLoading = true;

  @override
  void initState() {
    // context.read<NamesProvider>().getNames(context);
    super.initState();
    final namesProvider = context.read<NamesProvider>();
    namesProvider.getNames(context).then((_) {
      // Initialize audio player and set URL for the first name's audio
      if (namesProvider.names.isNotEmpty) {
        audioPlayer
            .setUrl(namesProvider.names[currentAudioIndex]?.audioUrl ?? '');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context: context, title: "99 Names of Allah"),
      body: Consumer4<LocalizationProvider, ThemProvider, AppColorsProvider,
          NamesProvider>(
        builder: (context, language, them, appColors, namesProvider, child) {
          return namesProvider.names.isNotEmpty
              ? PageView.builder(
                  itemCount: namesProvider.names.length,
                  itemBuilder: (context, index) {
                    Names names = namesProvider.names[index];
                    return Container(
                      height: double.maxFinite,
                      margin: EdgeInsets.only(
                          left: 20.w,
                          right: 20.w,
                          top:
                              Dimensions.height < 400 || Dimensions.height < 600
                                  ? 20.h
                                  : 70.h,
                          bottom:
                              Dimensions.height < 400 || Dimensions.height < 600
                                  ? 20.h
                                  : 68.h),
                      decoration: BoxDecoration(
                          color:
                              them.isDark ? AppColors.darkColor : Colors.white,
                          borderRadius: BorderRadius.circular(10.r),
                          boxShadow: const [
                            BoxShadow(
                                offset: Offset(0, 5),
                                blurRadius: 15,
                                color: Color.fromRGBO(0, 0, 0, 0.08))
                          ]),
                      child: Column(
                        children: [
                          Container(
                            margin: EdgeInsets.only(bottom: 4.h),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                    margin: EdgeInsets.only(
                                        top: 10.h, left: 10.w, right: 10.w),
                                    child: Image.asset(
                                      language.locale.languageCode == "ur" ||
                                              language.locale.languageCode ==
                                                  "ar"
                                          ? 'assets/images/app_icons/frame_left_t.png'
                                          : 'assets/images/app_icons/frame_right_t.png',
                                      height: 43.h,
                                      width: 43.w,
                                      color: appColors.mainBrandingColor,
                                    )),
                                Container(
                                    margin: EdgeInsets.only(
                                        top: 10.h, right: 10.w, left: 10.w),
                                    child: Image.asset(
                                      language.locale.languageCode == "ur" ||
                                              language.locale.languageCode ==
                                                  "ar"
                                          ? 'assets/images/app_icons/frame_right_t.png'
                                          : 'assets/images/app_icons/frame_left_t.png',
                                      height: 43.h,
                                      width: 43.w,
                                      color: appColors.mainBrandingColor,
                                    )),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  '${index + 1} of 99',
                                  style: TextStyle(
                                      color: appColors.mainBrandingColor,
                                      fontFamily: 'satoshi',
                                      fontWeight: FontWeight.w500,
                                      fontSize: 18.sp),
                                ),
                                Text(
                                  names.arabictext!,
                                  style: TextStyle(
                                      fontFamily: 'Al Majeed Quranic Font',
                                      fontWeight: FontWeight.w400,
                                      fontSize: Dimensions.height < 500 ||
                                              Dimensions.height < 600
                                          ? 40.sp
                                          : 61.sp),
                                  textAlign: TextAlign.center,
                                ),
                                Text(names.english!,
                                    style: TextStyle(
                                        fontFamily: 'satoshi',
                                        color: appColors.mainBrandingColor,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 18.sp)),
                                Text(names.englishMeaning!,
                                    style: TextStyle(
                                      fontFamily: 'satoshi',
                                      fontWeight: FontWeight.w500,
                                      fontSize: Dimensions.height < 300 ||
                                              Dimensions.height < 500 ||
                                              Dimensions.height < 600
                                          ? 10.sp
                                          : 16.sp,
                                    )),
                                Column(
                                  children: [
                                    InkWell(
                                        onTap: () {
                                          if (currentAudioIndex != index) {
                                            // Play new audio
                                            audioPlayer.stop();
                                            audioPlayer.setUrl(namesProvider
                                                    .names[index]?.audioUrl ??
                                                '');
                                            audioPlayer.play();
                                            currentAudioIndex = index;
                                            isAudioPlaying = true;
                                          } else {
                                            // Toggle play/pause for the current audio
                                            if (audioPlayer.playing) {
                                              audioPlayer.pause();
                                              isAudioPlaying = false;
                                            } else {
                                              audioPlayer.play();
                                              isAudioPlaying = true;
                                            }
                                          }
                                          setState(() {});
                                        },
                                        child: CircleButton(
                                          height: 58.h,
                                          width: 58.w,
                                          icon: Icon(
                                            isAudioPlaying
                                                ? Icons.pause
                                                : Icons.play_arrow,
                                            size: 28.h,
                                            color: Colors.white,
                                          ),
                                        )),
                                    SizedBox(
                                      height: 9.h,
                                    ),
                                    Text(
                                      isAudioPlaying
                                          ? 'Pause Audio'
                                          : 'Play Audio',
                                      style: TextStyle(
                                          fontFamily: 'satoshi',
                                          color: AppColors.grey3,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 12.sp),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                          Container(
                            alignment: Alignment.bottomCenter,
                            margin: EdgeInsets.only(top: 4.h),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                    margin: EdgeInsets.only(
                                        bottom: 10.h, left: 10.w, right: 10.w),
                                    child: Image.asset(
                                      language.locale.languageCode == "ur" ||
                                              language.locale.languageCode ==
                                                  "ar"
                                          ? 'assets/images/app_icons/frame_left_b.png'
                                          : 'assets/images/app_icons/frame_right_b.png',
                                      height: 43.h,
                                      width: 43.w,
                                      color: appColors.mainBrandingColor,
                                    )),
                                Container(
                                    margin: EdgeInsets.only(
                                        bottom: 10.h, right: 10.w, left: 10.w),
                                    child: Image.asset(
                                      language.locale.languageCode == "ur" ||
                                              language.locale.languageCode ==
                                                  "ar"
                                          ? 'assets/images/app_icons/frame_right_b.png'
                                          : 'assets/images/app_icons/frame_left_b.png',
                                      height: 43.h,
                                      width: 43.w,
                                      color: appColors.mainBrandingColor,
                                    )),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                )
              : const Center(
                  child: CircularProgressIndicator(
                    color: AppColors.mainBrandingColor,
                  ),
                );
        },
      ),
    );
  }
}
