import 'package:flutter/material.dart';
import 'package:nour_al_quran/shared/entities/surah.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';

import '../../../shared/localization/localization_constants.dart';
import '../../../shared/widgets/dua_container.dart';
import '../provider/home_provider.dart';
import 'home_row_widget.dart';

class VerseOfTheDayContainer extends StatelessWidget {
  const VerseOfTheDayContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeProvider>(
      builder: (context, value, child) {
        final Surah? surahNamea = Provider.of<HomeProvider>(context).surahName;
        return Column(
          children: [
            HomeRowWidget(
              text: localeText(context, 'verse_of_the_day'),
              buttonText: localeText(context, 'share'),
              onTap: () {
                Share.share("${value.verseOfTheDay.verseText}\n"
                    "${value.verseOfTheDay.translationText}\n"
                    "\u{200E}-- ${value.verseOfTheDay.surahId}:${value.verseOfTheDay.verseId} --\n"
                    "https://play.google.com/store/apps/details?id=com.fanzetech.holyquran");
              },
            ),
            DuaContainer(
              ref:
                  "${value.verseOfTheDay.surahId}:${value.verseOfTheDay.verseId}",
              text: value.verseOfTheDay.verseText,
              translation: value.verseOfTheDay.translationText,
              verseId: value.verseOfTheDay.verseId.toString(),
              surahName: surahNamea,
            ),
          ],
        );
      },
    );
  }
}

// String convertToArabicNumber(int? verseId) {
//   if (verseId == null) {
//     return '';
//   }

//   const List<String> arabicNumbers = [
//     '٠',
//     '١',
//     '٢',
//     '٣',
//     '٤',
//     '٥',
//     '٦',
//     '٧',
//     '٨',
//     '٩'
//   ];

//   if (verseId == 0) {
//     return arabicNumbers[0];
//   }

//   String arabicNumeral = '';
//   int id = verseId;

//   while (id > 0) {
//     int digit = id % 10;
//     arabicNumeral = arabicNumbers[digit] + arabicNumeral;
//     id ~/= 10;
//     print('Digit: $digit, Arabic Numeral: $arabicNumeral');
//   }

//   return arabicNumeral;
// }
