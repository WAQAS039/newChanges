import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive/hive.dart';
import 'package:nour_al_quran/pages/quran/pages/bookmarks/bookmarks_provider.dart';
import 'package:nour_al_quran/pages/quran/pages/surah/lastreadprovider.dart';
import 'package:nour_al_quran/pages/quran/providers/quran_provider.dart';
import 'package:nour_al_quran/pages/settings/pages/fonts/font_provider.dart';
import 'package:nour_al_quran/pages/settings/pages/translation_manager/translation_manager_provider.dart';
import 'package:nour_al_quran/shared/database/quran_db.dart';
import 'package:nour_al_quran/shared/entities/bookmarks.dart';
import 'package:nour_al_quran/shared/entities/quran_text.dart';
import 'package:nour_al_quran/shared/entities/last_seen.dart';
import 'package:nour_al_quran/shared/entities/surah.dart';
import 'package:nour_al_quran/pages/settings/pages/app_colors/app_colors_provider.dart';
import 'package:nour_al_quran/shared/localization/localization_constants.dart';
import 'package:nour_al_quran/shared/localization/localization_provider.dart';
import 'package:nour_al_quran/pages/quran/pages/resume/last_seen_provider.dart';
import 'package:nour_al_quran/pages/settings/pages/app_them/them_provider.dart';
import 'package:nour_al_quran/shared/utills/app_colors.dart';
import 'package:nour_al_quran/shared/widgets/custom_track_shape.dart';
import 'package:provider/provider.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import '../../settings/pages/my_state/my_state_provider_updated.dart';

class QuranTextView extends StatefulWidget {
  const QuranTextView({
    Key? key,
  }) : super(key: key);

  @override
  State<QuranTextView> createState() => _QuranTextViewState();
}

class _QuranTextViewState extends State<QuranTextView> {
  // for saving last seen
  int _lastPosition = 0;

  // from where user came it could be from home , lastSeen page
  int _fromWhere = 0;

  // Controller for quran texts
  ItemScrollController? _itemScrollController;
  ItemPositionsListener? _itemPositionsListener;
  late QuranProvider _quranProvider;

  // quran text
  List<QuranText> _quranText = [];
  @override
  void initState() {
    super.initState();
    context.read<QuranProvider>().startTimer();
    Future.delayed(Duration.zero,
        () => context.read<MyStateProvider>().startQuranReadingTimer("other"));
    _quranProvider = context.read<QuranProvider>();
    _itemScrollController = ItemScrollController();
    _itemPositionsListener = ItemPositionsListener.create();
    _fromWhere = _quranProvider.fromWhere!;
    _itemPositionsListener!.itemPositions.addListener(() {
      if (mounted) {
        if (_itemPositionsListener!.itemPositions.value.isNotEmpty) {
          _lastPosition =
              _itemPositionsListener!.itemPositions.value.first.index;
        }
      }
    });
    // _startTimer();
  }

  Future<void> saveLastSeen() async {
    QuranText quranText = _quranText[_lastPosition];
    Surah? surah =
        await QuranDatabase().getSpecificSurahName(quranText.surahId!);
    if (surah != null) {
      LastSeen lastSeen = LastSeen(
          surahNameArabic: surah.arabicName,
          surahName: surah.surahName,
          surahEnglish: surah.englishName,
          surahId: surah.surahId,
          ayahId: quranText.verseId,
          lastSeen: _lastPosition,
          juzName: _quranProvider.title!,
          isJuz: _quranProvider.isJuz!,
          juzId: _quranProvider.juzId! == -1 ? 0 : _quranProvider.juzId!);
      if (mounted) {
        context.read<LastSeenProvider>().saveLastSeen(lastSeen);
        // stop timer as well
        context.read<QuranProvider>().cancelTimer();
      }
    }
  }

  @override
  void dispose() {
    // stopTimer();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // i was not able to wrap appbar in consumer that's why i did like this
    Color appColor = context.read<AppColorsProvider>().mainBrandingColor;
    String title = _quranProvider.title!;
    return WillPopScope(
      onWillPop: () async {
        context.read<MyStateProvider>().stopQuranReadingTimer("other");
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: appColor,
          elevation: 0,
          leading: IconButton(
            onPressed: () {
              context.read<MyStateProvider>().stopQuranReadingTimer("other");
              saveLastSeen();
              Navigator.of(context).pop();
            },
            padding: EdgeInsets.only(left: 20.w, top: 20.41.h, bottom: 19.4.h),
            alignment: Alignment.topLeft,
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
          ),
          title: SizedBox(
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 24.sp,
                  fontFamily: "Al Majeed Quranic Font",
                  fontWeight: FontWeight.w400),
            ),
          ),
          actions: [
            IconButton(
                onPressed: () {
                  _showSettingDialog(context);
                },
                iconSize: 16.5.h,
                alignment: Alignment.topRight,
                padding:
                    EdgeInsets.only(right: 20.w, top: 19.75.h, bottom: 18.75.h),
                icon: const Icon(
                  Icons.settings,
                  color: Colors.white,
                ))
          ],
        ),
        body: Consumer5<QuranProvider, ThemProvider, LocalizationProvider,
            FontProvider, AppColorsProvider>(
          builder: (context, value, them, language, font, appColors, child) {
            return value.quranTextList.isNotEmpty
                ? ScrollablePositionedList.builder(
                    padding: EdgeInsets.only(bottom: 16.h),
                    itemCount: value.quranTextList.length,
                    itemScrollController: _itemScrollController,
                    itemPositionsListener: _itemPositionsListener,
                    // if 0 from home, 1 from surah or para, 2 from bookmark
                    initialScrollIndex: _fromWhere == 0
                        ? Hive.box('myBox').get("lastSeen").lastSeen ?? 0
                        : _fromWhere == 1
                            ? 0
                            : _quranProvider.bookmarkPosition != -1
                                ? _quranProvider.bookmarkPosition
                                : 0,
                    itemBuilder: (context, index) {
                      QuranText quranText = value.quranTextList[index];
                      // saving quran text in upper declare variable
                      _quranText = value.quranTextList;
                      bool isFirstVerse = (index == 0);
                      return Container(
                        margin:
                            EdgeInsets.only(top: 13.h, left: 5.w, right: 5.w),
                        decoration: BoxDecoration(
                            color: them.isDark
                                ? AppColors.darkColor
                                : Colors.white,
                            borderRadius: BorderRadius.circular(8.r),
                            boxShadow: [
                              BoxShadow(
                                  color: const Color.fromRGBO(0, 0, 0, 0.06),
                                  offset: const Offset(0, 5),
                                  blurRadius: 15.r,
                                  spreadRadius: 0),
                            ]),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            font.isQuranText
                                ? Container(
                                    margin: EdgeInsets.only(
                                      top: 16.h,
                                      left: 5.w,
                                      right: 5.w,
                                    ),
                                    child: Directionality(
                                      textDirection: TextDirection.rtl,
                                      child: Text.rich(
                                        TextSpan(
                                          children: [
                                            TextSpan(
                                              text: '${quranText.verseText!}﴿ ',
                                              style: TextStyle(
                                                fontFamily: font.finalFont,
                                                fontWeight: FontWeight.w400,
                                                fontSize:
                                                    font.fontSizeArabic.sp,
                                              ),
                                            ),
                                            TextSpan(
                                              text: convertToArabicNumber(
                                                  (quranText.verseId!)),
                                              style: TextStyle(
                                                // Add the desired font style for convertToArabicNumber
                                                // Example:
                                                fontFamily: 'satoshi',
                                                fontSize:
                                                    font.fontSizeArabic.sp,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            TextSpan(
                                              text: ' ﴾',
                                              style: TextStyle(
                                                fontFamily: font.finalFont,
                                                fontWeight: FontWeight.w400,
                                                fontSize:
                                                    font.fontSizeArabic.sp,
                                              ),
                                            ),
                                          ],
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  )
                                : const SizedBox.shrink(),
                            font.isTranslationText
                                ? Container(
                                    margin: EdgeInsets.only(
                                        top: 10.h,
                                        left: 5.w,
                                        right: 5.w,
                                        bottom: 15.h),
                                    child: Text(
                                      quranText.translationText!,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: font.fontSizeTranslation.sp,
                                          fontFamily: 'satoshi',
                                          fontWeight: FontWeight.w700),
                                    ),
                                  )
                                : const SizedBox.shrink(),
                            Container(
                              margin: EdgeInsets.only(
                                  left: 7.w, right: 13.w, bottom: 18.h),
                              decoration: BoxDecoration(
                                  color: !them.isDark
                                      ? Colors.white
                                      : AppColors.grey2,
                                  borderRadius: BorderRadius.circular(16.5.r),
                                  border: Border.all(color: AppColors.grey5)
                                  // boxShadow: [
                                  //   BoxShadow(
                                  //     color: const Color.fromRGBO(0, 0, 0, 0.08),
                                  //     offset: const Offset(0, 5),
                                  //     blurRadius: 15.r,
                                  //   ),
                                  // ]
                                  ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(
                                        top: 9.h,
                                        bottom: 10.h,
                                        left: 14.w,
                                        right: 23.w),
                                    child: Text(
                                      "${quranText.surahId}:${quranText.verseId}",
                                      style: TextStyle(
                                          fontSize: 13.sp,
                                          fontFamily: 'satoshi',
                                          color: !them.isDark
                                              ? AppColors.grey1
                                              : Colors.white,
                                          fontWeight: FontWeight.w700),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () async {
                                      // this will save bookmark in hive
                                      QuranText quranText = _quranText[index];
                                      Surah? surah = await value
                                          .getSpecificSurah(quranText.surahId!);
                                      if (surah != null) {
                                        if (quranText.isBookmark == 0) {
                                          value.bookmark(index, 1);
                                          Bookmarks bookmark = Bookmarks(
                                              surahId: surah.surahId,
                                              verseId: quranText.verseId,
                                              surahName:
                                                  "Surah ${surah.surahName}",
                                              surahArabic: surah.arabicName,
                                              juzId: _quranProvider.juzId,
                                              juzName: _quranProvider.title,
                                              isFromJuz: _quranProvider.isJuz,
                                              bookmarkPosition: index);
                                          context
                                              .read<BookmarkProvider>()
                                              .addBookmark(bookmark);
                                        } else {
                                          // to change state
                                          value.bookmark(index, 0);
                                          context
                                              .read<BookmarkProvider>()
                                              .removeBookmark(surah.surahId!,
                                                  quranText.verseId!);
                                        }
                                      }
                                    },
                                    child: Container(
                                      height: 18.h,
                                      width: 18.w,
                                      margin: EdgeInsets.only(
                                          bottom: 7.h,
                                          top: 8.h,
                                          right: 20.w,
                                          left: 20.w),
                                      child: CircleAvatar(
                                        backgroundColor:
                                            appColors.mainBrandingColor,
                                        child: SizedBox(
                                          height: 16.h,
                                          width: 16.w,
                                          child: CircleAvatar(
                                            backgroundColor: !them.isDark
                                                ? quranText.isBookmark == 1
                                                    ? appColor
                                                    : Colors.white
                                                : AppColors.grey2,
                                            child: Icon(
                                              Icons.bookmark,
                                              color: quranText.isBookmark == 1
                                                  ? Colors.white
                                                  : appColors.mainBrandingColor,
                                              size: 9.h,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  )
                : Center(
                    child: CircularProgressIndicator(
                      color: appColor,
                    ),
                  );
          },
        ),
        bottomNavigationBar: Consumer2<AppColorsProvider, QuranProvider>(
          builder: (context, appColor, quranProvider, child) {
            return quranProvider.isJuz == false &&
                    quranProvider.nextSurah != null
                ? Container(
                    color: appColor.mainBrandingColor,
                    height: 55.h,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        if (quranProvider.previousSurah !=
                            null) // Conditionally show the "Previous" text
                          InkWell(
                            child: Text(
                              'Previous Surah :',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14.sp,
                                fontFamily: 'satoshi',
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            onTap: () {
                              context.read<QuranProvider>().setSurahText(
                                    surahId: _quranProvider.nextSurah!.surahId!,
                                    title:
                                        'سورة ${_quranProvider.previousSurah!.arabicName}',
                                    fromWhere: 1,
                                  );
                              Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                  builder: (context) {
                                    return const QuranTextView();
                                  },
                                ),
                              );
                            },
                          ),
                        if (quranProvider.previousSurah !=
                            null) // Conditionally show the "سورة ${quranProvider.previousSurah!.arabicName}" text
                          Text(
                            'سورة${quranProvider.previousSurah!.arabicName}',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 24.sp,
                              fontFamily: 'Al Majeed Quranic Font',
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        InkWell(
                          onTap: () {
                            context.read<QuranProvider>().setSurahText(
                                  surahId: _quranProvider.nextSurah!.surahId!,
                                  title:
                                      'سورة ${_quranProvider.nextSurah!.arabicName}',
                                  fromWhere: 1,
                                );
                            Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                builder: (context) {
                                  return const QuranTextView();
                                },
                              ),
                            );
                          },
                          child: Container(
                            padding: EdgeInsets.only(
                              left: 14.w,
                              right: 14.w,
                              top: 9.h,
                              bottom: 9.h,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(17.r),
                            ),
                            child: Text(
                              'Next Surah',
                              style: TextStyle(
                                color: appColor.mainBrandingColor,
                                fontSize: 12.sp,
                                fontFamily: 'satoshi',
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                : const SizedBox.shrink();
          },
        ),
      ),
    );
  }

  Future<void> _showSettingDialog(BuildContext context) async {
    Future.delayed(Duration.zero, () {
      context.read<FontProvider>().init();
      context.read<TranslationManagerProvider>().init();
    });
    var style = TextStyle(
        fontSize: 14.sp, fontFamily: 'satoshi', fontWeight: FontWeight.w500);
    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r)),
          insetPadding: EdgeInsets.only(left: 12.w, right: 12.w),
          contentPadding: EdgeInsets.only(left: 16.w, right: 16.w),
          clipBehavior: Clip.antiAliasWithSaveLayer,
          content: Consumer3<AppColorsProvider, FontProvider,
              TranslationManagerProvider>(
            builder: (context, value, font, transProvider, child) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: double.maxFinite,
                    margin: EdgeInsets.only(top: 17.h, bottom: 17.h),
                    child: Text(
                      localeText(context, "read_quran_settings"),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontFamily: 'satoshi',
                          fontSize: 18.sp),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Text(
                        localeText(context, 'arabic'),
                        style: style,
                      ),
                      SizedBox(
                        height: 20.h,
                        width: 30.w,
                        child: FittedBox(
                          fit: BoxFit.fill,
                          child: CupertinoSwitch(
                              value: font.isQuranShow,
                              activeColor: value.mainBrandingColor,
                              onChanged: (value) => font.setIsQuranText(value)),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 16.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        localeText(context, 'translation'),
                        style: style,
                      ),
                      SizedBox(
                        height: 20.h,
                        width: 30.w,
                        child: FittedBox(
                          fit: BoxFit.fill,
                          child: CupertinoSwitch(
                              value: font.isTranShow,
                              activeColor: value.mainBrandingColor,
                              onChanged: (value) =>
                                  font.setIsTranslationText(value)),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 16.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                          width: MediaQuery.of(context).size.width * 0.2,
                          child: Text(
                            localeText(context, 'translation_language'),
                            style: style,
                          )),
                      DropdownButton<int>(
                        value: transProvider.defaultTranslations.indexWhere(
                            (element) =>
                                element.title ==
                                transProvider.defaultSelectedTranslation.title),
                        onChanged: (int? index) {
                          transProvider.selectTranslation(
                              transProvider.defaultTranslations[index!]);
                        },
                        underline: const SizedBox.shrink(),
                        alignment: Alignment.topRight,
                        items: transProvider.defaultTranslations
                            .map<DropdownMenuItem<int>>(
                              (e) => DropdownMenuItem<int>(
                                value: transProvider.defaultTranslations
                                    .indexOf(e),
                                child: Text(e.title!),
                              ),
                            )
                            .toList(),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 16.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        localeText(context, 'quran_text_size'),
                        style: style,
                      ),
                      Text(
                        '${font.fontSizeAr.toInt()} ${localeText(context, 'px')}',
                        style: style,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 16.h,
                  ),
                  SliderTheme(
                    data: SliderThemeData(
                        overlayShape: SliderComponentShape.noOverlay,
                        trackHeight: 8.h,
                        trackShape: CustomTrackShape()),
                    child: Slider(
                        value: font.fontSizeAr.toDouble(),
                        label: font.fontSizeAr.toString(),
                        min: 20.0,
                        max: 50.0,
                        activeColor: value.mainBrandingColor,
                        inactiveColor: AppColors.lightBrandingColor,
                        thumbColor: value.mainBrandingColor,
                        onChanged: (value) {
                          font.setFontSizeArabic(value.toDouble());
                        }),
                  ),
                  SizedBox(
                    height: 16.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        localeText(context, 'translation_text_size'),
                        style: style,
                      ),
                      Text(
                        '${font.fontSizeTrans.toInt()} ${localeText(context, 'px')}',
                        style: style,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 16.h,
                  ),
                  SliderTheme(
                    data: SliderThemeData(
                        overlayShape: SliderComponentShape.noOverlay,
                        trackHeight: 8.h,
                        trackShape: CustomTrackShape()),
                    child: Slider(
                        value: font.fontSizeTrans.toDouble(),
                        label: font.fontSizeTrans.toString(),
                        min: 12.0,
                        max: 50.0,
                        activeColor: value.mainBrandingColor,
                        inactiveColor: AppColors.lightBrandingColor,
                        thumbColor: value.mainBrandingColor,
                        onChanged: (value) {
                          font.setFontSizeTranslation(value.toDouble());
                        }),
                  ),
                  SizedBox(
                    height: 16.h,
                  ),
                  InkWell(
                    onTap: () {
                      context.read<FontProvider>().setQuranSettings(
                          font.fontSizeAr.toInt(),
                          font.fontSizeTrans.toInt(),
                          font.isQuranShow,
                          font.isTranShow);
                      transProvider.saveSelectedTranslation(context);
                      if (_quranProvider.surahId != -1) {
                        _quranProvider.setSurahText(
                            surahId: _quranProvider.surahId!,
                            title: _quranProvider.title!,
                            fromWhere: _quranProvider.fromWhere!);
                      } else {
                        _quranProvider.setJuzText(
                          juzId: _quranProvider.juzId!,
                          title: _quranProvider.title!,
                          fromWhere: _quranProvider.fromWhere!,
                          isJuz: true,
                        );
                      }
                      Navigator.of(context).pop();
                    },
                    child: Container(
                        margin: EdgeInsets.only(bottom: 22.h),
                        height: 50.h,
                        width: double.maxFinite,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6.r),
                            color: value.mainBrandingColor),
                        child: Text(
                          localeText(context, 'save_settings'),
                          style: TextStyle(
                              fontSize: 16.sp,
                              fontFamily: 'satoshi',
                              fontWeight: FontWeight.w700,
                              color: Colors.white),
                        )),
                  ),
                ],
              );
            },
          ),
        );
      },
    );
  }
}

// String formatTimeSpent(int timeInSeconds) {
//   Duration duration = Duration(seconds: timeInSeconds);
//
//   if (duration.inDays >= 1) {
//     int days = duration.inDays;
//     duration -= Duration(days: days);
//
//     if (duration.inHours > 0) {
//       int hours = duration.inHours;
//       duration -= Duration(hours: hours);
//
//       if (duration.inMinutes > 0) {
//         int minutes = duration.inMinutes;
//         return '${days}d${hours}h${minutes}m';
//       } else {
//         return '${days}d${hours}h';
//       }
//     } else {
//       return '${days}d';
//     }
//   } else if (duration.inHours >= 1) {
//     int hours = duration.inHours;
//     duration -= Duration(hours: hours);
//
//     if (duration.inMinutes > 0) {
//       int minutes = duration.inMinutes;
//       return '${hours}h${minutes}m';
//     } else {
//       return '${hours}h';
//     }
//   } else if (duration.inMinutes >= 1) {
//     int minutes = duration.inMinutes;
//     duration -= Duration(minutes: minutes);
//     if (duration.inSeconds > 0) {
//       int seconds = duration.inSeconds;
//       return '${minutes}m${seconds}s';
//     } else {
//       return '${minutes}m';
//     }
//   } else {
//     return '${duration.inSeconds}s';
//   }
// }
//
// String _formatDuration(Duration duration) {
//   if (duration.inDays > 0) {
//     final hours = duration.inHours - duration.inDays * 24;
//     final minutes = duration.inMinutes - duration.inHours * 60;
//     return '${duration.inDays}d $hours:$minutes';
//   } else if (duration.inSeconds <= 60) {
//     return '${duration.inSeconds} sec';
//   } else if (duration.inSeconds > 60 && duration.inMinutes <= 59) {
//     return '${duration.inMinutes} min';
//   } else {
//     final hours = duration.inHours;
//     final minutes = duration.inMinutes - duration.inHours * 60;
//     return '$hours:$minutes';
//   }
// }

String convertToArabicNumber(int? verseId) {
  if (verseId == null) {
    return '';
  }

  const List<String> arabicNumbers = [
    '٠',
    '١',
    '٢',
    '٣',
    '٤',
    '٥',
    '٦',
    '٧',
    '٨',
    '٩'
  ];

  if (verseId == 0) {
    return arabicNumbers[0];
  }

  String arabicNumeral = '';
  int id = verseId;

  while (id > 0) {
    int digit = id % 10;
    arabicNumeral = arabicNumbers[digit] + arabicNumeral;
    id ~/= 10;
    // print('Difeafeafeagit: $digit, Arabic Numerefaaefeafal: $arabicNumeral');
  }

  return arabicNumeral;
}
